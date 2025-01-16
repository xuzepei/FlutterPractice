import 'package:flutter/material.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text("Login Page"),
            ElevatedButton(
              onPressed: () {
                Tool.setValue("access_token", "123456");
                Navigator.pushNamed(context, mainPageRouteName);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
