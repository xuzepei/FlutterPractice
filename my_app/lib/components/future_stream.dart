import 'package:flutter/material.dart';

class FutureDemo extends StatelessWidget {
  const FutureDemo({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {

                  Future.delayed(Duration(seconds: 2), () {
                    return "hello future";
                    //throw AssertionError("It has an unknown error!");
                  }).then((data) {
                    //then方法的返回值也是一个Future
                    debugPrint("####: data: $data");
                  }).catchError((e) {
                    //有错误时，then不会执行，然后会捕获错误，执行这里
                    debugPrint("####: error: $e");
                  }).whenComplete(() {
                    //whenComplete不管成功还是失败都会执行
                    debugPrint("####: done");
                  });

                },
                child: Text("Future 用法1"))
          ],
        ),
      ),
    );
  }
}
