import 'package:flutter/material.dart';

class ComponentFlex extends StatelessWidget {
  const ComponentFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flex"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Flex的两个子widget按1：2来占据水平空间 ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      height: 30,
                    ),
                    flex: 1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      height: 30,
                    ),
                    flex: 2,
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text(
                "2. Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 100,child: Container(color: Colors.grey,child: Flex(direction: Axis.vertical, children: [
                Expanded(child: Container(color: Colors.yellow, height: 30,), flex: 2,),
                Spacer(flex: 1,),
                Expanded(child: Container(color: Colors.green, height: 30,), flex: 1,)
              ],),),)
            ],
          ),
        ));
  }
}
