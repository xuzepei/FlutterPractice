import 'package:flutter/material.dart';

class Keys {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const user_id = "key_user_id";
  static const user_token = "key_user_token";
  static const access_token = "key_access_token";
  static const region = "key_region";
  static const api_host = "key_api_host";
  static const password_login_account = "key_password_login_account";
  static const case_filter_type = "key_case_filter_type";
  static const case_filter_status = "key_case_filter_status";
  static const case_filter_source = "key_case_filter_source";

  static String getAPIHostKey(String region) {
    return "${region}_$api_host";
  }
}
