import 'package:flutter/material.dart';

class FittedBoxDemo extends StatelessWidget {
  FittedBoxDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //Row(children: [Text("1234567890"),Text("abcdefghijklmnopqrstuvwxyz", style: TextStyle(fontSize: 30),),Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")],mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
            FittedBox(fit: BoxFit.contain,child: Row(children: [Text("1234567890"),Text("abcdefghijklmnopqrstuvwxyz", style: TextStyle(fontSize: 30),),Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")],mainAxisAlignment: MainAxisAlignment.spaceEvenly,)),
            Container(
              width: 50,
              height: 50,
              color: Colors.red,
              child: FittedBox(fit:BoxFit.none,child: Container(width: 100, height: 100, color: Colors.blue)),
            ),
            Text("123"),
          ],
        ),
      ),
    );
  }
}
