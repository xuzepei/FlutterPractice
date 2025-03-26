import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panda_union/common/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appName = "Panda Union";

class Tool {
  // 私有的构造函数
  Tool._privateConstructor();

  // 静态实例
  static Tool? _instance;

  static Tool get instance {
    _instance ??= Tool._privateConstructor();
    return _instance!;
  }

  //存储非敏感数据
  static Future<bool> setValue(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else if (value is Map) {
      String jsonString = json.encode(value);
      if (jsonString.isNotEmpty) {
        return prefs.setString(key, jsonString);
      }
    } else {
      debugPrint("#### Error: setValue, value type not support");
    }

    return false;
  }

  //获取非敏感数据
  static Future<dynamic> getValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<Map<String, dynamic>?> getMap(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        Map<String, dynamic> map = json.decode(jsonString);
        return map;
      } catch (e) {
        debugPrint("#### Error: getMap, $e");
      }
    }

    return null;
  }

  //删除非敏感数据
  static Future<bool> removeValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  //处理地区数据
  static Future<bool> setRegion(String region) async {
    return Tool.setValue(Keys.region, region);
  }

  static Future<String> getRegion() async {
    try {
      String? region = await Tool.getString(Keys.region);
      return region ?? "";
    } catch (e) {
      return "";
    }
  }
}

//Global Functions
void logWithTime(String message) {
  final currentTime = DateTime.now().toIso8601String();
  debugPrint('[$currentTime] $message');
}

bool isEmptyOrNull(String? value) {
  return value?.trim().isEmpty ?? true;
}

bool isValidPhoneNumber(String? value) {
  if (isEmptyOrNull(value)) {
    return false;
  } else {
    // 使用正则验证手机号
    String phonePattern = r'^1[3-9]\d{9}$';
    RegExp regExp = RegExp(phonePattern);
    if (regExp.hasMatch(value!)) {
      return true;
    }
  }

  return false;
}

void showTopToast(BuildContext context, String message, IconData icon, Color backgroundColor) {

  // Display an icon separately (since `fluttertoast` does not support inline icons)
  FToast fToast = FToast();
  fToast.init(context); // Make sure to pass a valid BuildContext

  Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 10),
        Text(message, style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    ),
  );

  double safeAreaTop = MediaQuery.of(context).padding.top ; // ✅ Get SafeArea height

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: Duration(seconds: 2),
    positionedToastBuilder:(context, child, gravity) => Positioned(
      child: child,
      top: safeAreaTop,
      left: 0,
      right: 0,
    ),
  );

  // Future.delayed(Duration(seconds: 3), () {
  //   debugPrint("Toast dismissed!");
  //   fToast.removeCustomToast();
  // });
}

