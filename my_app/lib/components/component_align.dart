import 'package:flutter/material.dart';

class ComponentAlign extends StatelessWidget {
  const ComponentAlign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Align"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. Alignment"),
                Container(
                    width: 120,
                    height: 120,
                    color: Colors.yellow,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(Icons.add, size: 50),
                    )),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2. FractionalOffset"),
                Container(
                    width: 120,
                    height: 120,
                    color: Colors.yellow,
                    child: Align(
                      alignment: FractionalOffset(1, 1),
                      child: Icon(Icons.add, size: 50),
                    )),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3. Center"),
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Text("Center"*2),
                  ),
                ),
                SizedBox(height: 20,),
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Text("Center"*2),
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
