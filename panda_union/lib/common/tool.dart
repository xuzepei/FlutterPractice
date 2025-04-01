import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panda_union/common/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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

  static String invalidId = "00000000-0000-0000-0000-000000000000";

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

String localDateDesByISO(String dateStr) {
  // 检查是否是 Unix 时间戳
  if (isUnixTimestamp(dateStr)) {
    double? timestamp = double.tryParse(dateStr);
    if (timestamp == null) return dateStr;

    //确保为毫秒
    if (dateStr.length == 10) {
      timestamp = timestamp * 1000.0;
    }

    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.toInt(), isUtc: true);
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
  }

  List<String> dateFormats = [
    "yyyy/MM/dd'T'HH:mm:ss'Z'", // "2024/04/08T07:53:39Z"
    "yyyy-MM-dd HH:mm:ss.SSSXXX", // "2024-12-06 16:40:32.+08:00"
    "yyyy-MM-dd HH:mm:ss", // 常见时间格式
    "yyyy-MM-dd" // 仅日期
  ];

  for (String format in dateFormats) {
    try {
      DateFormat inputFormatter = DateFormat(format);
      DateTime date = inputFormatter.parse(dateStr);
      DateFormat outputFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");
      return outputFormatter.format(date.toLocal());
    } catch (e) {
      continue;
    }
  }

  return dateStr; // 如果解析失败，返回原字符串
}

bool isUnixTimestamp(String input) {
  return RegExp(r'^[0-9]{10,13}\$').hasMatch(input);
}
