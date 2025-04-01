import 'package:flutter/material.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/common/url_config.dart';

typedef LoginRequestCallback = void Function(
    int code, Map<String, dynamic>? data);

class LoginTool {
  LoginTool._privateConstructor();
  static final LoginTool _instance = LoginTool._privateConstructor();
  factory LoginTool() => _instance;

  static LoginTool get instance {
    return _instance;
  }

  bool _isRequesting = false;
  String _username = "";
  String _password = "";
  String _captcha = "";
  String _errorMsg = "";

  LoginRequestCallback? _callback;

  Future<void> login(String username, String password, String captcha, int mode,
      LoginRequestCallback? callback) async {
    _callback = callback;

    if (_isRequesting) {
      return;
    }

    if (isEmptyOrNull(username) ||
        (isEmptyOrNull(password) && isEmptyOrNull(captcha))) {
      handleLoginFailed(-7);
      return;
    }

    _username = username;
    _password = password;
    _captcha = captcha;

    _isRequesting = true;

    try {
      String urlString = await UrlConfig.instance.userTokenUrl();

      Map<String, dynamic> params = {
        "username": username,
      };
      if (!isEmptyOrNull(password)) {
        params["password"] = password;
      } else if (!isEmptyOrNull(captcha)) {
        params["captcha"] = captcha;
      }

      params["mode"] = mode; //1客户模式 0 用户模式

      await HttpRequest().post(urlString, params, (data) {
        if (data != null) {
          if (data.containsKey("success")) {
            var success = data["success"];
            if (success is bool && success) {
              if (data.containsKey("data")) {
                var dataMap = data["data"];
                if (dataMap is Map<String, dynamic>) {
                  if (dataMap.containsKey("code")) {
                    int code = dataMap["code"];
                    if (code == 0) {
                      handleLoginSucceed(dataMap);
                    } else {
                      handleLoginFailed(code);
                    }
                  }
                }
              }
            }
          }
        } else {
          handleLoginFailed(-100);
        }
      });

      return;
    } catch (e) {
      debugPrint("#### login error: $e");
    } finally {}

    handleLoginFailed(-100);
    return;
  }

  void handleLoginSucceed(Map<String, dynamic>? data) {
    _isRequesting = false;
    _callback?.call(0, data);
  }

  void handleLoginFailed(int code) {
    _isRequesting = false;

    //未绑定组织/客户
    if (-5 == code) {
      login(_username, _password, _captcha, 0, _callback);
    } else if (-7 == code) { //用户名或密码错误
      _callback?.call(code, null);
    } else {
      _callback?.call(code, null);
    }
  }
}
