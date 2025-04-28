import 'package:flutter/material.dart';

class MyColors {
  static const Color primaryColor = Color(0xFF575DFB);
  static const Color systemGray = Color(0xFF8E8E93);
  static const Color systemGray2 = Color(0xFFAEAEB2);
  static const Color systemGray3 = Color(0xFFC7C7CC);
  static const Color systemGray4 = Color(0xFFD1D1D6);
  static const Color systemGray5 = Color(0xFFE5E5EA);
  static const Color systemGray6 = Color(0xFFF2F2F7);
  static const Color systemBlue = Color(0xFF007AFF);
  static const Color appBarShadowColor = Color(0x55F2F2F7);
  static const Color tickColor = Color(0xFF4b4c4e);
  static const Color receivedCaseColor = Color(0xFFf5cdca);
  static const Color processingCaseColor = Color(0xFFf0e5b7);
  static const Color shippedCaseColor = Color(0xFFc3e0f2);
  static const Color completedCaseColor = Color(0xFFddeee4);
  static const Color coverCaseColor = Color(0xFFfff1e9);
  static const Color downloadedCaseColor = Color(0xFF71ba83);
  static const Color optionSelectedColor = Color(0xFF6598f7);
}

Color withHexString(String hexString) {
  if (hexString.isNotEmpty) {
    // 处理 0x 前缀
    if (hexString.startsWith("0x")) {
      hexString = hexString.substring(2);
    }
    // 处理 # 前缀
    else if (hexString.startsWith("#")) {
      hexString = hexString.substring(1);
    }

    if (hexString.trim().isNotEmpty) {
      try {
        // 转换为颜色
        return Color(int.parse(hexString, radix: 16) | 0xFF000000);
      } catch (e) {
        // 如果转换失败，返回透明色
        debugPrint("#### withHexString, invalid hex string: $hexString");
      }
    }
  }

  return Colors.transparent;
}
