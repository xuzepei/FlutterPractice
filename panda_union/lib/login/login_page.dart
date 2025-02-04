import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/common/button.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null //const Text("Login"),
          ),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Login",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor)),
            const SizedBox(height: 8),
            const Text("Log in now to check all your cases.",
                style: TextStyle(fontSize: 17)),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<int>(
                  children: {
                    0: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.transparent,
                        child: Text("Password", maxLines: 1)),
                    1: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.transparent,
                        child: Text("Verification Code", maxLines: 1)),
                  },
                  groupValue: _selectedIndex,
                  onValueChanged: (int? selectedIndex) {
                    debugPrint("#### selectedIndex: $selectedIndex");
                    setState(() {
                      _selectedIndex = selectedIndex!;
                    });
                  }),
            ),
                            Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: MyButton.show(() {
                          // _checkAPIHost().then((value) {
                          //   if (!mounted) return;
                          //   if (value) {
                          //     Navigator.pushNamed(context, mainPageRouteName);
                          //   } else {
                          //     MyDialog.show(
                          //         context,
                          //         "Tip",
                          //         "Please select a business operation region first.",
                          //         "OK");
                          //   }
                          // });
                        }, "Login"),
                      ),
                    ),
                  ],
                ),
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
