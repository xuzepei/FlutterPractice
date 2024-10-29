import 'package:flutter/material.dart';

class ComponentIndicator extends StatelessWidget {
  const ComponentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Indicator"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("1. progress in loop"),
                  SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.yellow,
                    //valueColor: AlwaysStoppedAnimation(Colors.green),
                    value: null,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("2. static progress"),
                  SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.red,
                    //valueColor: AlwaysStoppedAnimation(Colors.green),
                    value: 0.5,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("3. Circle progress"),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      color: Colors.red,
                      //valueColor: AlwaysStoppedAnimation(Colors.green),
                      strokeWidth: 20,
                      value: 0.5,
                    ),
                  ],
                ),
              ),
                              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("4. Set size of progress"),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 100, height: 100, child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation(Colors.green),
                    ),),
                    SizedBox(height: 40, child: LinearProgressIndicator(
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation(Colors.green),
                      value: .7,
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
