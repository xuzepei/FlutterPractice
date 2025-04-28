import 'package:flutter/material.dart';
import 'package:logger/web.dart';

import '../util/tool.dart';

class FutureDemo extends StatelessWidget {
  const FutureDemo({super.key, required this.title});
  final String title;

  Future<String> login(String username, String pwd) {
    return Future.delayed(Duration(seconds: 2), () {
      return username + "/" + pwd;
    });
  }

  Future<String> getUserInfo(String userId) {
    logWithTime("####: userId: $userId");

    return Future.delayed(Duration(seconds: 2), () {
      return "user info: $userId";
    });
  }

  Future saveUserInfo(String userInfo) {
    logWithTime("####: userInfo: $userInfo");

    return Future.delayed(Duration(seconds: 2), () {
      return "save success: $userInfo";
    });
  }

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
                  logWithTime("####: clicked Future 用法1");
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
                    debugPrint("####: done1");
                  });
                },
                child: Text("Future 用法1")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  logWithTime("####: clicked Future 用法2: callback hell");
                  login("zhangsan", "123456")
                      .then((userId) => getUserInfo(userId))
                      .then((userInfo) => saveUserInfo(userInfo))
                      .then((data) {
                    logWithTime("####: $data");
                  }).catchError((e) {
                    logWithTime("####: error: $e");
                  }).whenComplete(() {
                    logWithTime("####: done2");
                  });
                },
                child: Text("Future 用法2: callback hell")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  logWithTime("####: Future 用法3: 等待多个结果");
                  Future.wait([
                    Future.delayed(Duration(seconds: 2), () {
                      return "result1";
                    }),
                    Future.delayed(Duration(seconds: 6), () {
                      return "result2";
                    }),
                  ]).then((List<String> results) {
                    logWithTime("####: 等待所有任务完成才返回，这里等待6秒才返回");
                    logWithTime("####: results: $results");
                  }).catchError((e) {
                    logWithTime("####: error: $e");
                  }).whenComplete(() {
                    logWithTime("####: done3");
                  });
                },
                child: Text("Future 用法3: 等待多个结果")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  logWithTime("####: Stream 用法");

                  Stream.fromFutures([
                    Future.delayed(Duration(seconds: 3), () {
                      return "result1";
                    }),
                    Future.delayed(Duration(seconds: 3), () {
                      //return "result2";
                      throw AssertionError("Error");
                    }),
                    Future.delayed(Duration(seconds: 6), () {
                      return "result3";
                    }),
                  ]).listen((data) {
                    logWithTime("####: data: $data"); //完成的任务数据按时间先后返回
                  }, onError: (e) {
                    logWithTime("####: error: $e");
                  }, onDone: () {
                    logWithTime("####: done4");
                  });
                },
                child: Text("Stream 用法")),
          ],
        ),
      ),
    );
  }
}
