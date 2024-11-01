import 'package:flutter/material.dart';


class LayoutPrint<T> extends StatelessWidget {
  const LayoutPrint({
    super.key,
    this.tag,
    required this.child,
  });

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        debugPrint('${tag ?? "####:"} ${child.toString()}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
