import 'package:flutter/material.dart';
import 'package:panda_union/util/color.dart';

class MyButton {
  static ElevatedButton show(
      {required VoidCallback? onPressed, required String text}) {
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

  static InkWell buildTextButton(
      {required VoidCallback? onPressed, required String text}) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      splashColor: MyColors.systemGray6,
      highlightColor: MyColors.systemGray6,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Text.rich(
          TextSpan(
            text: text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                color: MyColors.primaryColor,
                decorationColor: MyColors.primaryColor,
                decorationThickness: 1.0),
          ),
        ),
      ),
    );
  }
}
