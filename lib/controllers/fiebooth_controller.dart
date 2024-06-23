import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fiebooth_portail/controllers/fiebooth_cookie.dart';
import 'package:fiebooth_portail/models/config_model.dart';
import 'package:fiebooth_portail/models/download_status.dart';
import 'package:fiebooth_portail/models/user_model.dart';
import 'package:fiebooth_portail/utils/error_utils.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;

class FieboothController {
  final FieboothCookie _fieboothCookie = FieboothCookie();
  static UserModel? loggedUser;
  final String _client = "10.42.0.191:5000";
  FieboothController() {
    
  }

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
      user = _handleUserPrevilege(user);
      // create the cookie
      _fieboothCookie.saveUser(user);
      print(
          "STATUS CODE = ${response.statusCode} userToken = ${user.userToken}");
      FieboothController.loggedUser = user;
      _handleDefaultImagesList(user);
      return user;
    } else {
      throw LoginException();
    }
  }

  void userLogout() {
    _fieboothCookie.logOutUser();
    FieboothController.loggedUser = null;
  }

  Stream<UserModel?> getUserConnected() async* {
    UserModel? streamUserState;
    await _handleUrlLogin();
    await _handleCookieAutoLogin();
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
        //no user connected check the cookies
        await _handleUrlLogin();
        await _handleCookieAutoLogin();
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }
  Future<void> _handleUrlLogin() async {
    print("base URI = ${Uri.base.path}");
    String path = Uri.base.path;
    path = path.replaceAll("/", "");
    if (path != "") {
      String decode = String.fromCharCodes(base64Decode(path));
      List<String> sequence = decode.split(";");
      UserModel user = UserModel(userName: sequence[0], userPassword: sequence[1]);
      await userLogin(user);
    }
  }

  Future<void> _handleCookieAutoLogin() async {
    dynamic cookieData = _fieboothCookie.getUser();
    if (cookieData != null) {
      if (cookieData.containsKey("userToken")) {
        try {
          String userToken = cookieData["userToken"] ?? "";

          UserModel? user = await whoAmI(userToken);
          if (user != null) {
            try {
              user.userLoginDate =
                  DateTime.tryParse(cookieData["userDate"] ?? "");
            } on FormatException catch (e) {
              e;
              user.userLoginDate = DateTime.now();
            }
            print("user connected ${user.userToken}");
            //user now logged
            FieboothController.loggedUser = user;
            _handleDefaultImagesList(user);
          }
        } catch (e) {
          print("The token is timed out $e");
          userLogout();
        }
      }
    }
  }

  Future<UserModel?> whoAmI(String userToken) async {
    Uri reqUri = _getUri("/users/me");
    Map<String, String> headers = getBearerHeader(userToken);
    http.Response response = await http.get(reqUri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseContent = jsonDecode(response.body);
      UserModel user = UserModel(
          userName: responseContent["username"],
          userPassword: "",
          userToken: userToken);
      user = _handleUserPrevilege(user);
      return user;
    } else {
      throw Exception("Request Error : Not Authorized !");
    }
  }

  UserModel _handleUserPrevilege(UserModel user) {
    if (user.userName == "admin") {
      user.userIsAdmin = true;
      user.userIsGuest = false;
      Globals.isUserAdmin.value = true;
    } else if (user.userName == "guest") {
      user.userIsGuest = true;
      user.userIsAdmin = false;
      Globals.isUserAdmin.value = false;
    } else {
      user.userIsGuest = false;
      user.userIsAdmin = false;
      Globals.isUserAdmin.value = false;
    }
    return user;
  }

  void _handleDefaultImagesList(UserModel user) {
    if (user.userName == "admin") {
      Globals.selectedUser = "all";
    } else {
      Globals.selectedUser = user.userName ?? "guest";
    }
  }

  Map<String, String> getBearerHeader([String token = ""]) {
    if (FieboothController.loggedUser != null) {
      return {
        "Authorization": "Bearer ${FieboothController.loggedUser!.userToken}",
      };
    } else {
      if (token != "") {
        return {
          "Authorization": "Bearer ${token}",
        };
      } else {
        throw Exception("Not connected Exception");
      }
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

  Future<List<String>?> getUserCurrentPhotos() async {
    UserModel? loggerUser = FieboothController.loggedUser;
    if (loggedUser != null) {
      Uri reqUri = _getUri("/images/currentuser");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.get(reqUri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseContent = jsonDecode(response.body);
        return List.from(responseContent["photos"]);
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    } else {
      throw Exception("Unauthorized : No user logged");
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
    } else if (isTheUserConnected(Globals.selectedUser) &&
        FieboothController.loggedUser != null &&
        FieboothController.loggedUser!.userIsGuest != null &&
        FieboothController.loggedUser!.userIsGuest!) {
          Globals.photosList.value = await getUserCurrentPhotos() ?? [];
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
    return [""];
  }

  Future<dynamic> getSetting(String settingName) async {
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

  Future printQrcodes() async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/printqr");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.post(reqUri, headers: headers);
      if (response.statusCode == 200) {
        // Map<String, dynamic> responseContent = jsonDecode(response.body);
        // return responseContent["value"];
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future downloadPhoto(String photoId) async {
    Uri photoUri = getPhotoUri(photoId);
    Map<String, String> headers = getBearerHeader(photoUri.toString());
    http.Response response = await http.get(photoUri, headers: headers);
    if (response.statusCode == 200) {
      // Get the file data as bytes
      Uint8List fileData = response.bodyBytes;
      print("download done");
      // Save the file using file_saver
      await FileSaver.instance.saveFile(name: photoId, bytes: fileData);
    } else {
      throw Exception("Request Error : Not Authorized !");
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
    if (oldValue != newValue) {
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

  Future createNewUser(String userName, String password) async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/users/new");
      Map<String, String> headers = getBearerHeader();
      headers["Content-Type"] = "application/json; charset=UTF-8";
      http.Response response = await http.post(reqUri,
          headers: headers,
          body: jsonEncode({
            "username": userName,
            "password": password,
            "hashpassword": "",
          }));
      if (response.statusCode == 200) {
        //
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future deleteUserPhoto(String userName) async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/images/user/$userName");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.delete(reqUri, headers: headers);
      if (response.statusCode == 200) {
        //
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future deleteAllphotos() async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/images/all");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.delete(reqUri, headers: headers);
      if (response.statusCode == 200) {
        //
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
  }

  Future<String?> getLogs() async {
    
      Uri reqUri = _getUri("/logs");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.get(reqUri, headers: headers);
      if (response.statusCode == 200) {
        String responseContent = jsonDecode(response.body);
        return responseContent;
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    
  }

  Stream<DownloadStatus> downloadUserPhotos(String user) async* {
    Map<String, String> headers = getBearerHeader();
    Uri downloadUri = _getUri("/images/download/$user");
    DownloadStatus downloadStatus = DownloadStatus(
      progress: 0,
      error: "",
      status: "DOWNLOADING",
    );
    print("COUCOU ${downloadStatus.progress} ${downloadUri.toString()}");
    Dio().getUri(downloadUri,
        options: Options(headers: headers, responseType: ResponseType.stream),
        onReceiveProgress: (int count, int total) {
      downloadStatus.progress = (count / total * 100).floor();
    }).then((response) async {
      (response.data as ResponseBody).stream.listen((event) async {
        await FileSaver.instance
            .saveFile(name: "photos_$user.zip", bytes: event);
      });
      print("download finished");
      downloadStatus.progress = 100;
    });
    while (downloadStatus.progress < 100) {
      yield downloadStatus;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future compressUserPhoto(String user) async {
    Map<String, String> headers = getBearerHeader();
    Uri downloadUri = _getUri("/images/compress/$user");
    http.Response response = await http.get(downloadUri, headers: headers);
    if (response.statusCode == 200) {
      // Get the file data as bytes
      print("compression start successfully");
    } else {
      throw Exception("Request Error : Not Authorized !");
    }
  }

  Future<DownloadStatus?> getDownloadStatus(String user) async {
    if (isUserAdmin()) {
      Uri reqUri = _getUri("/images/download/$user/status");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.get(reqUri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseContent = jsonDecode(response.body);
        print(responseContent);
        return DownloadStatus.fromObject(responseContent);
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    }
    return null;
  }

  Stream<DownloadStatus> downloadAll(String user) async* {
    // get the first status to know what to do
    DownloadStatus? downloadStatus = await getDownloadStatus(user);
    if (downloadStatus != null) {
      while (downloadStatus!.status != "DONE") {
        downloadStatus = await getDownloadStatus(user);
        if (downloadStatus!.status == "UNZIPPED") {
          // Photos ae not zipped so zip the file
          await compressUserPhoto(user);
        } else if (downloadStatus.status == "READY") {
          // launch the download
          yield* downloadUserPhotos(user);
          downloadStatus =
              DownloadStatus(status: "DONE", progress: 100, error: "");
        }
        yield downloadStatus;
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  Future rebootFiebooth() async {
    
      Uri reqUri = _getUri("/reboot");
      Map<String, String> headers = getBearerHeader();
      http.Response response = await http.get(reqUri, headers: headers);
      if (response.statusCode == 200) {
        print("Fiebooth reboot successfully");
      } else {
        throw Exception("Request Error : Not Authorized !");
      }
    
  }

  Future downloadVisitCard() async {
    Uri reqUri = _getUri("/card");
    Map<String, String> headers = getBearerHeader();
    http.Response response = await http.get(reqUri, headers: headers);
    if (response.statusCode == 200) {
      // Get the file data as bytes
      Uint8List fileData = response.bodyBytes;
      print("download done");
      // Save the file using file_saver
      await FileSaver.instance.saveFile(name: "CarteDeVisite", bytes: fileData);
    } else {
      throw Exception("Request Error : Not Authorized !");
    }
  }
}
