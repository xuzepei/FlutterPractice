import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderDemo extends StatelessWidget {
  const FutureBuilderDemo({super.key, required this.title});

  final String title;

  Future<String> fecthData() async {
    return Future.delayed(Duration(seconds: 5), () {
      return "This is a message from back-end.";
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: FutureBuilder(future: fecthData(), builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
           if(snapshot.hasError) {
             // 请求失败，显示错误
             return Text("Error: ${snapshot.error}");
           } else {
             // 请求成功，显示数据
             return Text("Contents: ${snapshot.data}");
           }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      }),),
    );
  }
}
