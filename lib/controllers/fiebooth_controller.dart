import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
      print(
          "STATUS CODE = ${response.statusCode} userToken = ${user.userToken}");
      FieboothController.loggedUser = user;
      return user;
    } else {
      throw LoginException();
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

  void userLogout() {}
  void getConfig() {}
  void setConfig() {}
  Future<List<String>?> getAllPhotoIdsList() async {
    Uri reqUri = _getUri("/images/all");
    Map<String, String> headers = getBearerHeader();
    http.Response response = await http.get(reqUri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseContent = jsonDecode(response.body);
      print(
          "STATUS CODE = ${response.statusCode} photos = ${responseContent["photos"]}");
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
    if(Globals.selectedUser == "all" && isUserAdmin()) {
      Globals.photosList.value = await getAllPhotoIdsList() ?? [];
    }else {
      if (isTheUserConnected(Globals.selectedUser) || isUserAdmin()) {
        Globals.photosList.value = await getPhotosIdByUser(Globals.selectedUser) ?? [];
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

  Future<List<String>?> getUserList () async {
    if(isUserAdmin()) {
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
  } 
}
