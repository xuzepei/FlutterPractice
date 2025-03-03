class Keys {
  static const user_id = "key_user_id";
  static const login_info = "key_login_info";
  static const access_token = "key_access_token";
  static const region = "key_region";
  static const api_host = "key_api_host";
  static const password_login_account = "key_password_login_account";

  static String getAPIHostKey(String region) {
    return "${region}_$api_host";
  }
}
