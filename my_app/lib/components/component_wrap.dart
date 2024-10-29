import 'package:flutter/material.dart';
import 'package:my_app/common/mychip.dart';

class ComponentWrap extends StatelessWidget {
  const ComponentWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wrap"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Colors.grey,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    MyChip(text: "Hello Flutter", textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:Colors.black), selectedColor: Colors.red, ),
                    Chip(
                        backgroundColor: Colors.red,
                        label: Text("张三"),
                        avatar: CircleAvatar(
                            backgroundColor: Colors.blue, child: Text("张"))),
                    Chip(
                      backgroundColor: Colors.grey,
                      avatar: CircleAvatar(
                          backgroundColor: Colors.blue, child: Text('L')),
                      label: Text('Lafayette'),
                    ),
                    Chip(
                      backgroundColor: Colors.grey,
                      avatar: CircleAvatar(
                          backgroundColor: Colors.blue, child: Text('M')),
                      label: Text('Mulligan'),
                    ),
                    Chip(
                      backgroundColor: Colors.grey,
                      avatar: CircleAvatar(
                          backgroundColor: Colors.blue, child: Text('L')),
                      label: Text('Laurens'),
                    ),
                  ],
                  alignment: WrapAlignment.start,
                  spacing: 8.0, //主轴(水平)方向间距
                  runSpacing: 4.0, //纵轴（垂直）方向间距
                ),
              ),
            ],
          ),
        ));
  }
}
