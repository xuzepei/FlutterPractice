import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tool {
  // 私有的构造函数
  Tool._privateConstructor();

  // 静态实例
  static final Tool _instance = Tool._privateConstructor();

  // 工厂构造函数
  factory Tool() {
    return _instance;
  }

  //存储非敏感数据
  static Future<void> setValue(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      debugPrint("#### Error: setValue, value type not support");
    }
  }

  //获取非敏感数据
  static Future<dynamic> getValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
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
