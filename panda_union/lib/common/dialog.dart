import 'package:flutter/material.dart';

class MyDialog {
  // static AlertDialog alert(
  //     BuildContext context, String title, String message, String buttonText) {
  //   return AlertDialog(
  //     actionsPadding: EdgeInsets.only(bottom: 8),
  //     title: Text(title),
  //     // shape: RoundedRectangleBorder(
  //     //   borderRadius: BorderRadius.circular(
  //     //       3.0), // 圆角
  //     // ),
  //     content: Text(message),
  //     actions: [
  //       TextButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: Text(buttonText),
  //       ),
  //     ],
  //   );
  // }

  static Future show(
      BuildContext context, String title, String message, String buttonText) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(bottom: 8),
          title: Text(title),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(
          //       3.0), // 圆角
          // ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
