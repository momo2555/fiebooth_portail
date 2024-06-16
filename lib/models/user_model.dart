class UserModel {
  String? userToken;
  String? userName;
  String? userPassword;
  String? userTokenType;
  DateTime? userLoginDate;
  bool? userIsAdmin;
  bool? userIsGuest;

  UserModel({this.userName, this.userPassword, this.userToken});

  UserModel.copy(UserModel user) {
    userToken =user.userToken;
    userName = user.userName;
    userPassword = user.userPassword;
    userTokenType = user.userTokenType;
    userLoginDate = user.userLoginDate;
    userIsAdmin = user.userIsAdmin;
    userIsGuest = user.userIsGuest;
  }
  /*@override
  bool operator==(Object other) {
    return other is UserModel && other.runtimeType == runtimeType && userToken == other.userToken && userName == other.userName;
  }
  @override
  int get hashCode => userToken.hashCode;*/
}