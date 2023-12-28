import 'package:flutter/material.dart';

class ComponentWrap extends StatelessWidget {
  const ComponentWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wrap"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  child: Wrap(
                    children: [
                      Chip(
                          backgroundColor: Colors.red,
                          label: Text("Hamilton"),
                          avatar: CircleAvatar(
                              backgroundColor: Colors.blue, child: Text("H"))),
                      Chip(
                          backgroundColor: Colors.red,
                          label: Text("张三"),
                          avatar: CircleAvatar(
                              backgroundColor: Colors.blue, child: Text("张"))),
                      Chip(
                        avatar: CircleAvatar(
                            backgroundColor: Colors.blue, child: Text('L')),
                        label: Text('Lafayette'),
                      ),
                      Chip(
                        avatar: CircleAvatar(
                            backgroundColor: Colors.blue, child: Text('M')),
                        label: Text('Mulligan'),
                      ),
                      Chip(
                        avatar: CircleAvatar(
                            backgroundColor: Colors.blue, child: Text('L')),
                        label: Text('Laurens'),
                      ),
                    ],
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    runSpacing: -10.0,
                  ),
                ),
              ),
            )));
  }
}
