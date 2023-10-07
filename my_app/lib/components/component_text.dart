import 'package:flutter/material.dart';

class ComponentText extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //3.1.1
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3.1.1 Text"),
                Text(
                  "Hello world",
                  textAlign: TextAlign.right,
                ),
                Text(
                  "Hello world! I'm Jack. " * 20,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  //overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            SizedBox(height: 20),
            //3.1.2
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("3.1.2 TextStyle"),
              Text(
                "Hello world",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.0,
                    height: 1.2,
                    fontFamily: "Courier",
                    background: Paint()..color = Colors.red,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
            ]),

            SizedBox(height: 20),
            //3.1.3
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3.1.3 TextSpan"),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "Home: "),
                  TextSpan(
                      text: "https://flutterchina.club",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red),
                      recognizer: null)
                ]))
              ],
            ),

            SizedBox(height: 20),
            //3.1.4
            Column(
              children: [
                Text("3.1.4 DefaultTextStyle"),
                DefaultTextStyle(
                  style: TextStyle(color: Colors.red, fontSize: 20),
                  child: Text(
                    "I'm Jack",
                    style: TextStyle(inherit: true),
                  ),
                )
              ],
            ),

            SizedBox(height: 20),
            //3.1.5
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3.1.5 Font"),
                Text("Font Mooli", style: TextStyle(fontFamily: "Mooli", fontSize: 30))
              ],
            )
          ],
        ),
      ),
    );
  }
}
