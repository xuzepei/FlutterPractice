import 'package:flutter/material.dart';

class ComponentStack extends StatelessWidget {
  const ComponentStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stack"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              color: Colors.yellow,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(constraints: BoxConstraints.expand(),child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: Text("Hello world!" * 2),
                        color: Colors.red,
                      ),
                      Positioned(
                        left: 18.0,
                        child: Text("I am Jack"),
                      ),
                      Positioned(
                        top: 0.0,
                        child: Text("Your friend"),
                      ),
                    ],
                  )),)
            )));
  }
}
