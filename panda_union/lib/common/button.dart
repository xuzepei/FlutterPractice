import 'package:flutter/material.dart';
import 'package:panda_union/common/color.dart';

class MyButton {
  static ElevatedButton build(
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

  static ElevatedButton buildOptionBtn(
      {required VoidCallback? onPressed, required String text}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 30)), 
          maximumSize: WidgetStatePropertyAll(Size(300, 30)),
          elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(MyColors.systemGray6),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)))),
        child: Text(text, style: TextStyle(color: Colors.black, fontSize: 14)));
  }

  static InkWell buildTextButton(
      {required VoidCallback? onPressed,
      required String text,
      TextStyle? textStyle}) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      splashColor: MyColors.systemGray6,
      highlightColor: MyColors.systemGray6,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        child: Text.rich(
          TextSpan(
            text: text,
            style: textStyle ??
                TextStyle(
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

  static Widget? appBarLeadingButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: IconButton(
          icon: Image.asset(
            "images/back_arrow_long.png",
            width: 26,
          ),
          splashColor: Colors.transparent, // Disable ripple effect
          highlightColor: Colors.transparent,
          onPressed: () {
            // You can specify what to do when the button is pressed
            Navigator.of(context)
                .pop(); // For example, go back to previous screen
          },
        ));
  }
}
