import 'package:flutter/cupertino.dart';
/*import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geteat/models/command_model.dart';
import 'package:geteat/models/restaurant_model.dart';
import 'package:geteat/models/sub_command_model.dart';
import 'package:geteat/models/user_profile_model.dart';*/

class Globals {
  static var kitchenSelectedRestaurantEdition = ValueNotifier<String>("");
  /*static RestaurantModel selectedRestaurantEdition = RestaurantModel();
  static List<CommandModel> commandStack = [];*/
  static bool commandPopupOn = false;
  static var homeIndex =  ValueNotifier<int>(0);
  static var userPosition = ValueNotifier<List<num>>([0.0,0.0]);
  static var userPositonComment = ValueNotifier<String>("");
  static var userAddress = ValueNotifier<String>("");
  static var userCity = ValueNotifier<String>("");
  static var goToKart = ValueNotifier<bool>(false);
  static var connexionWait = ValueNotifier<bool>(false);
  /*static var userCart = CommandModel();
  static List<CommandModel>? persistantCommands;
  static List<SubCommandModel>? persistantCart;
  static num persistantCartPrice = 0;
  static UserProfileModel persistanttUserProfile = UserProfileModel("", "", "", "");*/
  static void goBack(context) {
    Globals.goToKart.value = false;
    try {
       Navigator.pop(context);
    }catch(e) {
      print(e);
    }
   
  }

}
