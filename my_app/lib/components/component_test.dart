
import 'package:flutter/material.dart';

class ComponentTest extends StatelessWidget {
  const ComponentTest({super.key});

  @override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: Container(
          //width: 200,
          color: Colors.yellow,
          child: Container(
            color: Colors.blue,
          ),
        ));
  }
}
