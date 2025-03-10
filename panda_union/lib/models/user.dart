import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panda_union/common/errors.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/common/keys.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';
import 'package:panda_union/util/url_config.dart';

class User {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _isInited = false;

  String region = "";

  String userId = "";
  String username = "";
  String phoneNumber = "";
  String email = "";
  String region_country = "";
  String region_state = "";
  String region_city = "";
  String avatar = "";

  String orgName = "";
  String organizationContact = "";
  String organizationContactNumber = "";
  String organizationEmail = "";
  String organizationCreditCode = "";
  int custType = 0; //0未知，2是诊所，3是技工厂
  String custId = "";
  bool hasCertified = true;

  String token_type = "";
  String access_token = "";
  String refresh_token = "";
  String expires_in = "";

  Timer? _tokenTimer;

  // 私有的构造函数
  User._privateConstructor();

  // 静态实例（直接初始化）
  static final User _instance = User._privateConstructor();
  // 工厂构造函数返回单例
  factory User() => _instance;

  static User get instance {
    return _instance;
  }

  Future<void> init() async {
    if (_isInited == true) {
      return;
    }

    try {
      region = await Tool.getRegion();

      Map<String, dynamic>? data = await Tool.getMap(Keys.user_token);
      if (data != null) {
        if (data.containsKey("access_token")) {
          String temp = data["access_token"];
          if (temp.isNotEmpty) {
            access_token = temp;
          }
        }

        if (data.containsKey("refresh_token")) {
          String temp = data["refresh_token"];
          if (temp.isNotEmpty) {
            refresh_token = temp;
          }
        }

        if (data.containsKey("expires_in")) {
          String temp = data["expires_in"];
          if (temp.isNotEmpty) {
            expires_in = temp;
          }
        }

        _isInited = true;
      }
    } catch (e) {
      debugPrint("#### init error: $e");
    }
  }

  Future<bool> isLoggedIn() async {
    // try {
    //   String? value = await Tool.getString(access_token_key);
    //   if (!isEmptyOrNull(value)) {
    //     return true;
    //   }
    // } catch (e) {
    //   return false;
    // }

    if (access_token.isNotEmpty) {
      return true;
    }

    return false;
  }

  String authorization() {
    if (access_token.isNotEmpty) {
      return "Bearer $access_token";
    }

    return "";
  }

  int updateUserToken(Map<String, dynamic> dataMap) {
    if (dataMap.containsKey("code")) {
      int code = dataMap["code"];
      if (code == 0) {
        if (dataMap.containsKey("content")) {
          var content = dataMap["content"];
          if (content is Map<String, dynamic>) {
            var saveMap = <String, dynamic>{};

            if (content.containsKey("AccessToken")) {
              String temp = content["AccessToken"];
              if (temp.isNotEmpty) {
                access_token = temp;
                saveMap["access_token"] = access_token;
              } else {
                return -7;
              }
            }

            if (content.containsKey("RefreshToken")) {
              String temp = content["RefreshToken"];
              if (temp.isNotEmpty) {
                refresh_token = temp;
                saveMap["refresh_token"] = refresh_token;
              }
            }

            if (content.containsKey("ExpiresIn")) {
              int temp = content["ExpiresIn"];
              expires_in = temp.toString();
              saveMap["expires_in"] = expires_in;
            }

            Tool.setValue(Keys.user_token, saveMap);

            return 0;
          }
        }
      }
    }
    return -1;
  }

  Future<void> updateUserInfo() async {
    try {
      String urlString = await UrlConfig.instance.currentUserUrl();

      await HttpRequest().get(urlString, (data) {
        if (data != null) {
          if (data.containsKey("success")) {
            var success = data["success"];
            if (success is bool && success) {
              if (data.containsKey("data")) {
                var dataMap = data["data"];
                if (dataMap is Map<String, dynamic>) {
                  if (dataMap.containsKey("userId")) {
                    String temp = dataMap["userId"];
                    if (temp.isNotEmpty) {
                      User.instance.userId = temp;
                      Tool.setValue(Keys.user_id, temp);
                    }
                  }

                  if (dataMap.containsKey("username")) {
                    String temp = dataMap["username"];
                    if (temp.isNotEmpty) {
                      User.instance.username = temp;
                    }
                  }

                  if (dataMap.containsKey("avatar")) {
                    String temp = dataMap["avatar"];
                    if (temp.isNotEmpty) {
                      User.instance.avatar = temp;
                    } else {
                      User.instance.avatar = "";
                    }
                  }

                  if (dataMap.containsKey("custType")) {
                    int custType = dataMap["custType"];
                    User.instance.custType = custType;

                    if (custType == 2 || custType == 3) {
                      if (dataMap.containsKey("custId")) {
                        String temp = dataMap["custId"];
                        if (temp.isNotEmpty) {
                          User.instance.custId = temp;
                        } else {
                          User.instance.custId = "";
                          User.instance.hasCertified = false;
                        }
                      }
                    } else {
                      User.instance.hasCertified = false;
                    }
                  }
                }
              }
            }
          }
        }
      });
    } catch (e) {
      debugPrint("#### updateUserInfo error: $e");
    } finally {}
  }

  void startTokenRefreshTimer() {
    refreshUserToken();

    stopTokenRefreshTimer();
    _tokenTimer = Timer.periodic(Duration(hours: 1), (timer) {
      refreshUserToken();
    });
  }

  void stopTokenRefreshTimer() {
    _tokenTimer?.cancel();
    _tokenTimer = null;
  }

  Future<void> refreshUserToken() async {
    try {
      String urlString = await UrlConfig.instance.refreshUserTokenUrl();

      if (User.instance.refresh_token.isEmpty) {
        handleRefreshUserTokenFailed();
        return;
      }

      String bodyString =
          "client_id=mobile&client_secret=secret&grant_type=refresh_token&login_module=1&refresh_token=${User.instance.refresh_token}";

      await HttpRequest().postWithBodyString(urlString, bodyString, (data) async {
        if (data != null) {
          bool b = updateUserTokenByRefreshing(data);
          if (b) {
            await User.instance.updateUserInfo();
            return;
          }
        }

        handleRefreshUserTokenFailed();
      });
    } catch (e) {
      debugPrint("#### updateUserInfo error: $e");
    } finally {}
  }

  void handleRefreshUserTokenFailed() {
    User.instance.logout();
    goToWelcomePage();
  }

  void goToWelcomePage() {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(welcomePageRouteName, (route) => false);
  }

  bool updateUserTokenByRefreshing(Map<String, dynamic> dataMap) {
    var saveMap = <String, dynamic>{};

    if (dataMap.containsKey("access_token")) {
      String temp = dataMap["access_token"];
      if (temp.isEmpty) {
        return false;
      }
      access_token = temp;
      saveMap["access_token"] = access_token;
    }

    if (dataMap.containsKey("refresh_token")) {
      String temp = dataMap["refresh_token"];
      if (temp.isNotEmpty) {
        refresh_token = temp;
        saveMap["refresh_token"] = refresh_token;
      }
    }

    if (dataMap.containsKey("expires_in")) {
      int temp = dataMap["expires_in"];
      expires_in = temp.toString();
      saveMap["expires_in"] = expires_in;
    }

    Tool.setValue(Keys.user_token, saveMap);

    return true;
  }

  Future<void> logout() async {
    stopTokenRefreshTimer();

    userId = "";
    username = "";
    phoneNumber = "";
    email = "";
    region_country = "";
    region_state = "";
    region_city = "";
    avatar = "";

    orgName = "";
    organizationContact = "";
    organizationContactNumber = "";
    organizationEmail = "";
    organizationCreditCode = "";
    custType = 0; //0未知，2是诊所，3是技工厂
    custId = "";
    hasCertified = true;

    token_type = "";
    access_token = "";
    refresh_token = "";
    expires_in = "";

    await Tool.removeValue(Keys.access_token);
    await Tool.removeValue(Keys.user_id);
    await Tool.removeValue(Keys.user_token);
  }
}
