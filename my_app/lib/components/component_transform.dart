import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformDemo extends StatelessWidget {
  TransformDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                  color: Colors.black,
                  child: Transform(
                    transform: Matrix4.skewY(0.3),
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.deepOrange,
                      child: Text("Apartment for rent!"),
                    ),
                  )),
              SizedBox(
                height: 60,
              ),
              Text(
                "1. Translate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 60,
              ),
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.translate(
                    offset: Offset(10, 5),
                    child: Text("Hello world"),
                  )),
              SizedBox(
                height: 60,
              ),
              Text(
                "2. Rotate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 60,
              ),
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: Text("Hello world"),
                  )),
              SizedBox(
                height: 60,
              ),
              Text(
                "3. Scale",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 60,
              ),
              DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Text("Hello world"),
                  )),
              SizedBox(
                height: 60,
              ),
              Text(
                "4. First translate and then rotate vs first rotate and then translate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Transform.translate(
                        offset: Offset(20, 10),
                        child: Transform.rotate(
                            angle: math.pi / 2, child: Text("Hello world")),
                      )),
                  DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Transform.rotate(
                        angle: math.pi / 2,
                        child: Transform.translate(
                            offset: Offset(20, 10), child: Text("Hello world")),
                      )),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "5. RotatedBox",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text("Hello world"),
                      )),
                      Text(
                        "你好",
                        style: TextStyle(color: Colors.green),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
