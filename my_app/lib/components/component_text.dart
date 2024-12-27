import 'dart:math';

import 'package:flutter/material.dart';
import '../util/tool.dart';

class ComponentText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
      ),
      body: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(20),
        child: Builder(builder: (context) {
          //向上在父级中查找‘Scafford’
          Scaffold? temp = context.findAncestorWidgetOfExactType<Scaffold>();
          if (temp != null) {
            logWithTime("####:" + "${(temp.appBar as AppBar).title.toString()}");
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //3.1.1
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3.1.1 Text"),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0, top: 8, right: 0, bottom: 8),
                    child: Text(
                      "Hello world",
                      textAlign: TextAlign.left,
                      textScaler: TextScaler.linear(3), //修改字体大小的便捷方法
                    ),
                  ),
                  Text(
                    "Long long text in one line." * 20,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Hello world! I'm Jack. " * 20,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              SizedBox(height: 20),
              //3.1.2
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("3.1.2 TextStyle"),
                Text(
                  "Hello world",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50.0,
                      height: 1.2,
                      fontFamily: "Mooli",
                      backgroundColor: Colors.red,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed),
                ),
              ]),

              SizedBox(height: 20),
              //3.1.3
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3.1.3 TextSpan"),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "Home: "),
                    TextSpan(
                        text: "https://flutterchina.club",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue),
                        recognizer: null)
                  ]))
                ],
              ),

              SizedBox(height: 20),
              //3.1.4
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3.1.4 DefaultTextStyle"),
                  DefaultTextStyle(
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    textAlign: TextAlign.left,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Default Text Style",
                          style: TextStyle(inherit: true),
                        ),
                        Text("I'm Jack."),
                        Text("I'm Jack too.",
                            style:
                                TextStyle(inherit: false, color: Colors.green)),
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: 20),
              //3.1.5
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3.1.5 Font"),
                  Text("Font Mooli",
                      style: TextStyle(fontFamily: "Mooli", fontSize: 30))
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
