class Errors {
  static String default_error = "Sorry, an unexpected error has occurred.";

  static String getLoginError(int errorCode) {
    switch (errorCode) {
      case -1:
      case -3:
        return "Internal server error.";
      case -2:
      case -7:
        return "Please verify your phone number and verification code.";
      default:
        return default_error;
    }
  }
}
