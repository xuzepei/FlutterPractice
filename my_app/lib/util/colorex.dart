
import 'package:flutter/material.dart';

class ColorEx extends Color {
  ColorEx(super.value);

  static Color? withHexString(String hexString) {

    if(hexString != null && hexString.isNotEmpty) {

      // 处理 0x 前缀
      if(hexString.startsWith("0x")) {
        hexString = hexString.substring(2);
      }
      // 处理 # 前缀
      else if(hexString.startsWith("#")) {
        hexString = hexString.substring(1);
      }

      if(hexString.trim().isNotEmpty) {
        try {
          // 转换为颜色
          return Color(int.parse(hexString, radix: 16) | 0xFF000000);
        } catch (e) {
          // 如果转换失败，返回 null
          debugPrint("Invalid hex string: $hexString");
        }
      }
    }

    return null;
  }
}