import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DecoratedBoxDemo extends StatelessWidget {
  DecoratedBoxDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, offset: Offset(2, 2), blurRadius: 4.0),
            ],
          ),
          child: Container(
            //constraints: BoxConstraints(maxWidth: 100),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
