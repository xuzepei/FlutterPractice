import 'package:flutter/material.dart';
import 'package:panda_union/util/color.dart';

class MyButton {
  static ElevatedButton show(VoidCallback? onPressed, String text) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(MyColors.primaryColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)))),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)));
  }
}
