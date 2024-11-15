import 'package:flutter/material.dart';

class SingleChildScrollViewDemo extends StatelessWidget {
  SingleChildScrollViewDemo({super.key, required this.title});

  final String title;

  String testStr = "ABCDEFGHIJKLMNOPQRSTUVWSYZ";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: testStr.split("").map((c) {
                  return Text(
                    c,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}
