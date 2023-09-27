class UserModel {
  String? userToken;
  String? userName;
  String? userPassword;
  String? userTokenType;
  DateTime? userLoginDate;
  bool? userIsAdmin;

  UserModel({this.userName, this.userPassword, this.userToken});
  
}