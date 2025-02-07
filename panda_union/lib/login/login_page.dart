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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSegmentedControl() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl<int>(
          children: {
            0: Container(
                padding: EdgeInsets.all(8),
                color: Colors.transparent,
                child: Text("Password",
                    maxLines: 1, style: TextStyle(fontSize: 14))),
            1: Container(
                padding: EdgeInsets.all(8),
                color: Colors.transparent,
                child: Text("Verification Code",
                    maxLines: 1, style: TextStyle(fontSize: 14))),
          },
          groupValue: _selectedIndex,
          onValueChanged: (int? selectedIndex) {
            debugPrint("#### selectedIndex: $selectedIndex");
            setState(() {
              _selectedIndex = selectedIndex!;
            });
          }),
    );
  }

  Widget _buildLoginButton() {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null //const Text("Login"),
          ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Login",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: MyColors.primaryColor)),
                  const SizedBox(height: 8),
                  const Text("Log in now to check all your cases.",
                      style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 26),
                  _buildSegmentedControl(),
                  const SizedBox(height: 800),
                  _buildLoginButton(),
                  
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
          ),
        ),
      ),
    );
  }
}
