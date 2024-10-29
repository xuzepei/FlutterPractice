import 'package:flutter/material.dart';

class ComponentConstrainedBox extends StatelessWidget {
  ComponentConstrainedBox({super.key, required this.title});

  final String title;

  final Widget redBox =
      DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. ConstrainedBox",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: 50),
                    child: Container(
                      height: 5.0, //这个高度设置不起作用，因为父组件的约束优先
                      child: redBox,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("2. SizedBox", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  SizedBox(width: 80, height: 80, child: redBox),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
