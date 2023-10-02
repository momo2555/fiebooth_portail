import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fiebooth_portail/models/config_model.dart';
import 'package:fiebooth_portail/models/user_model.dart';
import 'package:fiebooth_portail/utils/error_utils.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:http/http.dart' as http;

class FieboothController {
  static UserModel? loggedUser;
  final String _client = "192.168.137.60:5000";
  /*FieboothController() {
    
  }*/
  Uri _getUri(String route) {
    return Uri.http(_client, route);
  }

  Future<UserModel?> userLogin(UserModel user) async {
    var reqUri = _getUri("/token");
    //_dio.post(reqUri.toString(), )
    http.Response response = await http.post(reqUri, body: {
      "username": user.userName,
      "password": user.userPassword,
    }, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    Map<String, dynamic> responseContent = jsonDecode(response.body);
    if (response.statusCode == 200) {
      user.userToken = responseContent["access_token"];
      user.userTokenType = responseContent["token_type"];
      user.userLoginDate = DateTime.now();
      // TODO : define admin rank in the api side
      if (user.userName == "admin") {
        user.userIsAdmin = true;
      }
      // create the cookie
      //document.cookie =  Cookie("fiebooth-usr", responseContent["access_token"]);
      print(
          "STATUS CODE = ${response.statusCode} userToken = ${user.userToken}");
      FieboothController.loggedUser = user;
      return user;
    } else {
      throw LoginException();
    }
  }

  void userLogout() {
    FieboothController.loggedUser = null;
  }

  Stream<UserModel?> getUserConnected() async* {
    UserModel? streamUserState;
    while (true) {
      if (streamUserState != FieboothController.loggedUser) {
        if (FieboothController.loggedUser != null &&
            FieboothController.loggedUser!.userToken != null) {
          streamUserState = UserModel.copy(FieboothController.loggedUser!);
          yield FieboothController.loggedUser;
        } else {
          yield null;
        }
      } else {

      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Map<String, String> getBearerHeader() {
    if (FieboothController.loggedUser != null) {
      return {
        "Authorization": "Bearer ${FieboothController.loggedUser!.userToken}",
      };
    } else {
      throw Exception("Not connected Exception");
    }
  }

  Future<List<String>?> getAllPhotoIdsList() async {
    Uri reqUri = _getUri("/images/all");
    Map<String, String> headers = getBearerHeader();
    http.Response response = await http.get(reqUri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseContent = jsonDecode(response.body);
      return List.from(responseContent["photos"]);
    } else {
      throw Exception("Request Error : Not Authorized !");
    }
  }

  Future<List<String>?> getPhotosIdByUser(String user) async {
    UserModel? loggerUser = FieboothController.loggedUser;
    if (loggedUser != null) {
      if (loggedUser!.userIsAdmin == true || loggedUser!.userName == user) {
        Uri reqUri = _getUri("/images/user/$user");
        Map<String, String> headers = getBearerHeader();
        http.Response response = await http.get(reqUri, headers: headers);
        if (response.statusCode == 200) {
          Map<String, dynamic> responseContent = jsonDecode(response.body);
          return List.from(responseContent["photos"]);
        } else {
          throw Exception("Request Error : Not Authorized !");
        }
      } else {
        throw Exception("Unauthorized : No enought privilege");
      }
    } else {
      throw Exception("Unauthorized : No user logged");
    }
  }

  Future updateImageList() async {
    if (Globals.selectedUser == "all" && isUserAdmin()) {
      Globals.photosList.value = await getAllPhotoIdsList() ?? [];
    } else {
      if (isTheUserConnected(Globals.selectedUser) || isUserAdmin()) {
        Globals.photosList.value =
            await getPhotosIdByUser(Globals.selectedUser) ?? [];
      }
    }
  }

  Uri getPhotoUri(String photoId) {
    return _getUri("/image/$photoId");
  }

  Uri getPhotoThumbnailUri(String photoId) {
    return _getUri("/image/thumbnail/$photoId");
  }

  bool isTheUserConnected(String user) {
    return (loggedUser != null && loggedUser!.userName == user);
  }

  bool isUserAdmin() {
    UserModel? loggedUser = FieboothController.loggedUser;
    return (loggedUser != null && loggedUser.userIsAdmin == true);
  }

  Future deleteImage(String imageId) async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/image/delete/$imageId");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.delete(reqUri, headers: headers);
      if (response.statusCode != 200) {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future printImage(String imageId) async {
    Uri reqUri = _getUri("/print/$imageId");
    Map<String, String> headers = getBearerHeader();
    http.Response response = await http.post(reqUri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception("Request Error : Not Authorized !");
    }
  }

  Future<List<String>?> getUserList() async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/users/all");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.get(reqUri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseContent = jsonDecode(response.body);
        return List.from(responseContent["users"]);
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
    return null;
  }

  Future<dynamic> getSetting(String settingName) async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/setting/$settingName");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.get(reqUri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseContent = jsonDecode(response.body);
        return responseContent["value"];
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future<ConfigModel> getSettings() async {
    ConfigModel config = ConfigModel.empty();
    await Future.wait([
      getSetting("user_text").then((value) => config.userText = value),
      getSetting("wifi_ssid").then((value) => config.wifiSsid = value),
      getSetting("wifi_password").then((value) => config.wifiPassword = value),
      getSetting("brightness").then((value) => config.brightness = value),
      getSetting("contrast_default")
          .then((value) => config.defaultContrast = value),
      getSetting("brightness_default")
          .then((value) => config.defaultBrightness = value),
      getSetting("use_keyboard").then((value) => config.useKeyboard = value),
      getSetting("contrast").then((value) => config.contrast = value),
    ]);
    return config;
  }

  Future setSetting(String setting, oldValue, newValue) async {
    if (oldValue != newValue && isUserAdmin()) {
      Uri reqUri = _getUri("/setting/edit");
      Map<String, String> headers = getBearerHeader();
      headers["Content-Type"] = "application/json; charset=UTF-8";
      http.Response response = await http.post(
        reqUri,
        headers: headers,
        body: jsonEncode({
          "key": setting,
          "value": newValue,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseContent = jsonDecode(response.body);
        return responseContent["value"];
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future<void> setSettings(
      ConfigModel oldSettings, ConfigModel newSettings) async {
    await Future.wait([
      setSetting("user_text", oldSettings.userText, newSettings.userText),
      setSetting("wifi_ssid", oldSettings.wifiSsid, newSettings.wifiSsid),
      setSetting(
          "wifi_password", oldSettings.wifiPassword, newSettings.wifiPassword),
      setSetting("brightness", oldSettings.brightness, newSettings.brightness),
      setSetting("contrast_default", oldSettings.defaultContrast,
          newSettings.defaultContrast),
      setSetting("brightness_default", oldSettings.defaultBrightness,
          newSettings.defaultBrightness),
      setSetting(
          "use_keyboard", oldSettings.useKeyboard, newSettings.useKeyboard),
      setSetting("contrast", oldSettings.contrast, newSettings.contrast),
    ]);
  }
}
