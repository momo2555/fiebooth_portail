 /*class LoginException implements Exception {
    
    String _message = "";
  
    ValueException([String message = 'Bad login or password, login to Fiebooth failed !']) {
      this._message = message;
    }
  
    @override
    String toString() {
      return _message;
    }
  }*/
  
  class LoginException implements Exception {
  final dynamic message;

  LoginException([this.message = "Bad login or password, login to Fiebooth failed !"]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
  