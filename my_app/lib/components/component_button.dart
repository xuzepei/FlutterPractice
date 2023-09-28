import 'package:flutter/material.dart';

class ComponentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Button"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
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
                        print("pressed the elevated button");
                      },
                      child: Text("normal"))
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
                        print("pressed the text button");
                      },
                      child: Text("normal"))
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
                        print("pressed the outlined button");
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
                        print("pressed the outlined button");
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
                    onPressed: (){

                    },
                  ),
                  OutlinedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("添加"),
                    onPressed: (){
                      
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.info),
                    label: Text("详情"),
                    onPressed: (){
                      
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
