import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const access_token_key = "access_token";
const region_key = "region";

class Tool {
  // 私有的构造函数
  Tool._privateConstructor();

  // 静态实例
  static Tool? _instance;

  static Tool get instance {
    if (_instance == null) {
      return Tool._privateConstructor();
    }
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

  //删除非敏感数据
  static Future<bool> removeValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  //处理地区数据
  static Future<bool> setRegion(String region) async {
    return setValue(region_key, region);
  }

  static Future<String> getRegion() async {
    String? region = await getString(region_key);
    return region ?? "";
  }
}

//Global Functions
void logWithTime(String message) {
  final currentTime = DateTime.now().toIso8601String();
  debugPrint('[$currentTime] $message');
}

bool isEmptyOrNull(String? value) {
  return value == null || value.trim().isEmpty;
}
