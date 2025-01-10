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
  static Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
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
