import 'package:flutter/material.dart';

class ComponentLinearLayout extends StatelessWidget {
  const ComponentLinearLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("LinearLayout"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 200,
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.red,
                        child: Column(
                          children: [
                            Text("Hello"),
                            Text("World!"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
