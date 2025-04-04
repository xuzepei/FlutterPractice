import 'package:flutter/material.dart';
import 'package:panda_union/common/keys.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/common/tool.dart';

class UrlConfig {
  // 私有的构造函数
  UrlConfig._privateConstructor();

  // 静态实例
  static final UrlConfig _instance = UrlConfig._privateConstructor();
  factory UrlConfig() => _instance;
  static UrlConfig get instance {
    return _instance;
  }

  final baseUrlList = [
    ("cn", "https://cn.freqtek.com"),
    ("eu", "https://eu.freqtek.com"),
    ("in", "https://in.freqtek.com"),
    ("en", "https://en.freqtek.com"),
  ];

  String getBaseUrl() {
    String region = User.instance.region;

    for (var item in baseUrlList) {
      if (region.isEmpty) {
        break;
      } else {
        if (item.$1 == region) {
          return item.$2;
        }
      }
    }

    return baseUrlList[0].$2;
  }

  Future<Map?> getAPIHostByRegion() async {
    String region = User.instance.region;
    if (region.isEmpty) {
      return null;
    }

    try {
      Map? value = await Tool.getMap(Keys.getAPIHostKey(region));
      return value;
    } catch (e) {
      debugPrint("#### Error: getAPIHostByRegion, $e");
    }

    return null;
  }

  void saveAPIHostByRegion(Map dataMap) {
    String region = User.instance.region;
    if (region.isEmpty) {
      return;
    }

    Tool.setValue(Keys.getAPIHostKey(region), dataMap);
  }

  Future<String> getAPIHostByKey(String key) async {
    try {
      Map? dataMap = await getAPIHostByRegion();
      if (dataMap == null) {
        return "";
      }

      for (var entry in dataMap.entries) {
        var k = entry.key;
        var value = entry.value;
        if (k is String && value is String) {
          if (k.toLowerCase() == key.toLowerCase()) {
            return value;
          }
        }
      }
    } catch (e) {
      debugPrint("#### Error: getAPIHostByKey, $e");
    }

    return "";
  }

  String apiHostUrl() {
    return "${getBaseUrl()}/common/services";
  }

  Future<String> userTokenUrl() async {
    String key = "dsdhost";

    try {
      String host = await getAPIHostByKey(key);
      if (host.isNotEmpty) {
        return "$host/token";
      }
    } catch (e) {
      debugPrint("#### Error: userTokenUrl, $e");
    }

    return "";
  }

  Future<String> refreshUserTokenUrl() async {
    String key = "corehost";

    try {
      String host = await getAPIHostByKey(key);
      if (host.isNotEmpty) {
        return "$host/connect/token";
      }
    } catch (e) {
      debugPrint("#### Error: refreshUserTokenUrl, $e");
    }

    return "";
  }

  Future<String> currentUserUrl() async {
    String key = "selfhost";

    try {
      String host = await getAPIHostByKey(key);
      if (host.isNotEmpty) {
        return "$host/user/current";
      }
    } catch (e) {
      debugPrint("#### Error: currentUserUrl, $e");
    }

    return "";
  }

  Future<String> caseListUrl() async {
    String key = "casemainhost";

    try {
      String host = await getAPIHostByKey(key);
      if (host.isNotEmpty) {
        return "$host/getpaging";
      }
    } catch (e) {
      debugPrint("#### Error: caseListUrl, $e");
    }

    return "";
  }

  Future<String> caseFileHostUrl() async {
    String key = "casesavedhost";

    try {
      String host = await getAPIHostByKey(key);
      if (host.isNotEmpty) {
        return "$host/preview";
      }
    } catch (e) {
      debugPrint("#### Error: caseListUrl, $e");
    }

    return "";
  }
}
