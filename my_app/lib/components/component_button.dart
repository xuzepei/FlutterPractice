import 'package:flutter/material.dart';

class ComponentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Button"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //3.2.1
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3.2.1 ElevatedButton",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        debugPrint("####: pressed the elevated button");
                      },
                      child: Text("ElevatedButton",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blue))),
                  ElevatedButton(
                      onPressed: () {
                        debugPrint("pressed the elevated button2");
                      },
                      child: Text("ElevatedButton2",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red)),
                  ElevatedButton(
                      onPressed: () {
                        debugPrint("pressed the elevated button3");
                      },
                      child: Text("ElevatedButton3",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.green),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)))))
                ],
              ),
              SizedBox(height: 20),

              //3.2.2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3.2.2 TextButton",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint("####: pressed the text button");
                    },
                    child: Text(
                      "normal",
                      style: TextStyle(fontSize: 30),
                    ),
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory),
                  )
                ],
              ),
              SizedBox(height: 20),

              //3.2.3
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3.2.3 OutlinedButton",
                    style: TextStyle(fontSize: 20),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        debugPrint("####: pressed the outlined button");
                      },
                      child: Text("normal"))
                ],
              ),
              SizedBox(height: 20),

              //3.2.4
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3.2.4 IconButton",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        debugPrint("pressed the outlined button");
                      },
                      icon: Icon(
                        Icons.tiktok,
                        color: Colors.red,
                      )),
                ],
              ),
              SizedBox(height: 20),

              //3.2.5
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3.2.5 Button with icon",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.send),
                    label: Text("发送"),
                    onPressed: () {},
                  ),
                  OutlinedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("添加"),
                    onPressed: () {},
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.info),
                    label: Text("详情"),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
