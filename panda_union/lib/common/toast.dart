import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  success,
  error,
  warning,
}

class Toast {
  // 私有的构造函数
  Toast._privateConstructor();

  // 静态实例
  static Toast? _instance;

  static Toast get instance {
    _instance ??= Toast._privateConstructor();
    return _instance!;
  }

  static void showByType(BuildContext context, String message, ToastType type) {
    // Display an icon separately (since `fluttertoast` does not support inline icons)
    FToast fToast = FToast();
    fToast.init(context); // Make sure to pass a valid BuildContext

    Color backgroundColor = Colors.white;
    if (type == ToastType.success) {
      backgroundColor = Colors.green;
    } else if (type == ToastType.error) {
      backgroundColor = Colors.red;
    } else if (type == ToastType.warning) {
      backgroundColor = Colors.orange;
    }

    IconData? icon;
    if (type == ToastType.success) {
      icon = Icons.check_circle;
    } else if (type == ToastType.error) {
      icon = Icons.cancel;
    } else if (type == ToastType.warning) {
      icon = Icons.error;
    }

    Widget toast = Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );

    double safeAreaTop =
        MediaQuery.of(context).padding.top; // ✅ Get SafeArea height

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child, gravity) => Positioned(
        top: safeAreaTop,
        left: 0,
        right: 0,
        child: child,
      ),
    );

    // Future.delayed(Duration(seconds: 3), () {
    //   debugPrint("Toast dismissed!");
    //   fToast.removeCustomToast();
    // });
  }

  static void show(BuildContext context, String message, IconData icon,
      Color backgroundColor) {
    // Display an icon separately (since `fluttertoast` does not support inline icons)
    FToast fToast = FToast();
    fToast.init(context); // Make sure to pass a valid BuildContext

    Widget toast = Padding(
      padding: const EdgeInsets.only(left: 35, right: 35),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );

    double safeAreaTop =
        MediaQuery.of(context).padding.top; // ✅ Get SafeArea height

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child, gravity) => Positioned(
        top: safeAreaTop,
        left: 0,
        right: 0,
        child: child,
      ),
    );

    // Future.delayed(Duration(seconds: 3), () {
    //   debugPrint("Toast dismissed!");
    //   fToast.removeCustomToast();
    // });
  }
}
