import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/util/layout_print.dart';

import '../util/tool.dart';

class LayoutBuilderWidget extends StatelessWidget {
  LayoutBuilderWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (kDebugMode) {
        debugPrint("####: constraints.maxWidth: $constraints.maxWidth");
      }
      //父组件宽度大于等于200时，显示两列
      if (constraints.maxWidth >= 160) {
        var children1 = <Widget>[];
        var children2 = <Widget>[];
        for (var i = 0; i < children.length; i++) {
          if (i % 2 == 0) {
            children1.add(children[i]);
            debugPrint("####: $children1");
          } else {
            children2.add(children[i]);
          }
        }
        return Container(
          color: Colors.yellow,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 15.0,
            runSpacing: 15.0,
            children: [
              Column(children: children1),
              Column(
                children: children2,
              ),
            ],
          ),
        );
      } else {
        return Wrap(direction: Axis.vertical,spacing: 30.0, children: children);
      }
    });
  }
}

class LayoutBuilderDemo extends StatelessWidget {
  const LayoutBuilderDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var _children = [
      Text("A"),
      Text("B"),
      Text("A"),
      Text("B"),
      Text("A"),
      Text("B")
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          width: 200,
          padding: EdgeInsets.all(8),
          color: Colors.red,
          child: Column(
            children: [
              LayoutBuilderWidget(children: _children),
              LayoutPrint(child: Text("XX")),
            ],
          ),
        ));
  }
}
