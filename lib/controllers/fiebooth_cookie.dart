import 'dart:convert';
import 'dart:html';

import 'package:fiebooth_portail/models/user_model.dart';

class FieboothCookie {

  void saveUser(UserModel user) {
    Map <String, String> data = {
      "userToken" : user.userToken??"",
      "userDate" : (user.userLoginDate??DateTime.now()).toIso8601String(), 
    };
    _createCookie("fbusrtkn", jsonEncode(data), 1);   

  }
  dynamic getUser() {
    String? cookie = _readCookie("fbusrtkn");
    if (cookie!=null && cookie!="" ) {
      print(cookie);
      try {
        
        return jsonDecode(cookie) ;
      }
      catch (e) {
        print("Unable to read the cookie : $e");
      }
    } 
  }
  void logOutUser() {
   _eraseCookie("fbusrtkn");
  }

  void _createCookie(String name, String value, int? days) {
  String expires;
  if (days != null)  {
    DateTime now = DateTime.now();
    DateTime date =  DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch + days*24*60*60*1000);
    expires = "expires=${date.toString()}";    
  } else {
    DateTime then = DateTime.fromMillisecondsSinceEpoch(0);
    expires = "expires=${then.toString()}";
  }
  document.cookie = "$name=$value; $expires; path=/";
}

String? _readCookie(String name) {
  String nameEQ = "$name=";
  List<String> ca = (document.cookie??"").split(';');
  for (int i = 0; i < ca.length; i++) {
    String c = ca[i];
    c = c.trim();
    if (c.indexOf(nameEQ) == 0) {
      return c.substring(nameEQ.length);
    }
  }
  return null;  
}

void _eraseCookie(String name) {
  _createCookie(name, '', null);
}
}