import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                Navigator.pushNamed(context, "main_tab_view");
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
