import 'package:flutter/material.dart';

class ComponentStack extends StatelessWidget {
  const ComponentStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stack"),
        ),
        body: Container(
          color: Colors.grey,
          child: ConstrainedBox(constraints: BoxConstraints.expand(),child: Stack(
            alignment: Alignment.center,
            //fit: StackFit.expand,
            children: [
              Container(
                child: Text("Hello world!" * 2),
                color: Colors.red,
              ),
              Positioned(
                left: 28.0,
                child: Text("I am Jack"),
              ),
              Positioned(
                top: 0.0,
                child: Text("Your friend"),
              ),
            ],
          )),
        ));
  }
}
