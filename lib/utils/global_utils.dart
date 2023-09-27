import 'package:flutter/cupertino.dart';
import 'package:fiebooth_portail/models/user_model.dart';

class Globals {
  static bool commandPopupOn = false;
  static var homeIndex =  ValueNotifier<int>(0);
  static UserModel? user;
  static var goToKart = ValueNotifier<bool>(false);
  static var connexionWait = ValueNotifier<bool>(false);

  static String selectedUser = "all";
  static var photosList = ValueNotifier<List<String>>([]);

  static void goBack(context) {
    Globals.goToKart.value = false;
    try {
       Navigator.pop(context);
    }catch(e) {
      print(e);
    }
   
  }

}
