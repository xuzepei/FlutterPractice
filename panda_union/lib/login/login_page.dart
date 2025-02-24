import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/common/button.dart';
import 'package:panda_union/common/dialog.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 0; // 0: 用户名登录, 1: 手机号登录
  final _accountFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final FocusNode _accountFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _codeFocus = FocusNode();

  String _accountInputError = "";
  String _passwordInputError = "";
  final String _phoneInputError = "";
  final String _codeInputError = "";

  bool _obscurePassword = true;

  bool _isButtonDisabled = false; // 控制按钮是否禁用
  int _counter = 0; // 倒计时的秒数
  late Timer _countDowntimer; // 用来倒计时

  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    try {
      if (_countDowntimer.isActive) {
        _countDowntimer.cancel();
      }
    } catch (e) {
      debugPrint("#### Error: ${e.toString()}");
    }

    _accountController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();

    _accountFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    _codeFocus.dispose();

    super.dispose();
  }

  Widget _buildSegmentedControl() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl<int>(
          children: {
            0: Container(
                padding: EdgeInsets.all(8),
                color: Colors.transparent,
                child: Text("Via Password",
                    maxLines: 1, style: TextStyle(fontSize: 14))),
            1: Container(
                padding: EdgeInsets.all(8),
                color: Colors.transparent,
                child: Text("Via Code",
                    maxLines: 1, style: TextStyle(fontSize: 14))),
          },
          groupValue: _selectedIndex,
          onValueChanged: (int? selectedIndex) {
            debugPrint("#### selectedIndex: $selectedIndex");

            FocusScope.of(context).unfocus();

            setState(() {
              _selectedIndex = selectedIndex!;
            });
          }),
    );
  }

  Widget _buildAccountLogin() {
    return Form(
      key: _accountFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _accountController,
            focusNode: _accountFocus,
            decoration: InputDecoration(
              hintText: "Phone number or email",
              hintStyle: const TextStyle(color: MyColors.systemGray),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: 0), //调整hintText的位置，使其垂直居中
              prefixIcon: const Icon(Icons.person, size: 30),
            ),
            onChanged: (value) {
              if (!isEmptyOrNull(value)) {
                setState(() {
                  _accountInputError = "";
                });
              }
            },
            validator: (value) {
              if (!isEmptyOrNull(value)) {
                setState(() {
                  _accountInputError = "";
                });
              } else {
                setState(() {
                  _accountInputError = "Please enter your account.";
                });
              }

              return null;
            },
            textInputAction: TextInputAction.next,
          ),
          Container(
            height: 1, // 设置下划线的高度
            color: MyColors.systemGray6, // 设置下划线颜色
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _accountInputError,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
          //const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: MyColors.systemGray),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 0), //调整hintText的位置，使其垂直居中
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: MyColors.systemGray6)),
                prefixIcon: const Icon(Icons.lock, size: 30),
                suffixIcon: IconButton(
                    // icon: Icon(
                    //     _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    //     size: 30),
                    icon: Image.asset(
                      _obscurePassword
                          ? 'images/close_eye.png'
                          : 'images/open_eye.png', // Path to your local image
                      width: 25, // Set the width of the icon
                      height: 25, // Set the height of the icon
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    })),
            onChanged: (value) {
              if (!isEmptyOrNull(value)) {
                setState(() {
                  _passwordInputError = "";
                });
              }
            },
            validator: (value) {
              if (!isEmptyOrNull(value)) {
                setState(() {
                  _passwordInputError = "";
                });
              } else {
                setState(() {
                  _passwordInputError = "Please enter your password.";
                });
              }
              return null;
            },
            textInputAction: TextInputAction.done,
          ),
          Container(
            height: 1, // 设置下划线的高度
            color: MyColors.systemGray6, // 设置下划线颜色
          ),

          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _passwordInputError,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

          Text.rich(
            TextSpan(
              text: "Forgot password?",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  color: MyColors.primaryColor,
                  decorationColor: MyColors.primaryColor,
                  decorationThickness: 1.0),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("#### clicked Forgot password");
                },
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(4),
            splashColor: MyColors.systemGray5,
            highlightColor: MyColors.systemGray5,
            onTap: () {
              // Handle the tap action
              print("####Text tapped!");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Text.rich(
                TextSpan(
                  text: "Forgot password?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      color: MyColors.primaryColor,
                      decorationColor: MyColors.primaryColor,
                      decorationThickness: 1.0),
                ),
              ),
            ),
          ),

          TextButton(
              onPressed: () {
                debugPrint("#### Forgot password");
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 0), // Set the size by padding
                backgroundColor:
                    Colors.transparent, // Optional: background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(0), // Optional: rounded corners
                ),
                foregroundColor:
                    Colors.white, // Text color// Default splash effect
              ),
              child: const Text("Forgot password?",
                  style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: MyColors.primaryColor))),
        ],
      ),
    );
  }

  Widget _buildPhoneLogin() {
    return Form(
      key: _codeFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _phoneController,
            focusNode: _phoneFocus,
            decoration: InputDecoration(
              hintText: "Phone number",
              hintStyle: const TextStyle(color: MyColors.systemGray),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 0), //调整hintText的位置，使其垂直居中
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.systemGray6)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.systemGray6)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.systemGray6)),
              prefixIcon: const Icon(Icons.phone_iphone, size: 30),
            ),
            validator: (value) {
              if (!isValidPhoneNumber(value)) {
                return "Please enter a valid phone number.";
              }
              return null;
            },
          ),
          //const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _codeController,
                  focusNode: _codeFocus,
                  decoration: const InputDecoration(
                    hintText: "Code",
                    hintStyle: TextStyle(color: MyColors.systemGray),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 20, horizontal: 0), //调整hintText的位置，使其垂直居中
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColors.systemGray6)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColors.systemGray6)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColors.systemGray6)),
                    prefixIcon: Icon(Icons.tag, size: 30),
                  ),
                  validator: (value) {
                    if (isEmptyOrNull(value)) {
                      return "Please enter the verification code";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () {
                        debugPrint("#### Get Code");
                        _startCountdown();
                      },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 40),
                  backgroundColor: MyColors.primaryColor, // 背景色设置为蓝色
                  foregroundColor: Colors.white, // 文字颜色设置为白色
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0), // 圆角
                  ),
                ),
                child: Text(_isButtonDisabled ? "${_counter}s" : "Get Code"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 开始倒计时的函数
  void _startCountdown() {
    setState(() {
      _counter = 20; // 重置倒计时的秒数
      _isButtonDisabled = true; // 禁用按钮
    });

    try {
      if (_countDowntimer.isActive) {
        _countDowntimer.cancel();
      }
    } catch (e) {
      debugPrint("#### Error: ${e.toString()}");
    }

    _countDowntimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          _isButtonDisabled = false; // 启用按钮
        });
        _countDowntimer.cancel(); // 停止倒计时
      }
    });
  }

  Widget _buildTerms() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          side: BorderSide(color: Colors.black, width: 1.5),
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value!;
            });
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text.rich(
              TextSpan(
                text: "I have read and agree to the ",
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(color: MyColors.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint("#### Terms of Service");
                      },
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(color: MyColors.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint("#### Privacy Policy");
                      },
                  ),
                  TextSpan(text: "."),
                ],
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: MyButton.show(
                onPressed: () {
                  _selectedIndex == 0
                      ? _submitAccountForm()
                      : _submitCodeForm();
                },
                text: "Login"),
          ),
        ),
      ],
    );
  }

  void _submitAccountForm() {
    FocusScope.of(context).unfocus();

    if (_agreeToTerms == false) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text(
      //       "Please agree to the Terms of Service and Privacy Policy."),
      // ));

      MyDialog.show(context, "Tip",
          "Please agree to the Terms of Service and Privacy Policy.", "OK");
      return;
    }

    _accountFormKey.currentState!.validate();

    String account = _accountController.text;
    String password = _passwordController.text;
    if (account.isNotEmpty && password.isNotEmpty) {
      // 只有所有 `TextFormField` 都验证通过，才会执行这里
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("验证通过，提交成功！"),
      // ));

      debugPrint("#### account: $account, password: $password");
    }
  }

  void _submitCodeForm() {
    FocusScope.of(context).unfocus();

    if (_agreeToTerms == false) {
      MyDialog.show(context, "Tip",
          "Please agree to the Terms of Service and Privacy Policy.", "OK");
      return;
    }

    _codeFormKey.currentState!.validate();

    String phone = _phoneController.text;
    String code = _codeController.text;
    if (phone.isNotEmpty && code.isNotEmpty) {
      // 只有所有 `TextFormField` 都验证通过，才会执行这里
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("验证通过，提交成功！"),
      // ));

      debugPrint("#### phone: $phone, code: $code");
    }
  }

  Widget _buildRegisterTip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(TextSpan(text: "Don't have an account? ", children: [
          TextSpan(
            text: "Register",
            style: TextStyle(
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: MyColors.primaryColor,
                decorationThickness: 1.0),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                debugPrint("#### clicked Register");
                _goToRegisterPage();
              },
          )
        ]))
      ],
    );
  }

  void _goToRegisterPage() {
    Navigator.pushNamed(context, registerPageRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null //const Text("Login"),
          ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
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
                  const Text("Log in now to view all your cases.",
                      style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 26),
                  _buildSegmentedControl(),
                  const SizedBox(height: 30),
                  // 根据 _selectedSegment 显示不同的输入框
                  _selectedIndex == 0
                      ? _buildAccountLogin()
                      : _buildPhoneLogin(),

                  const SizedBox(height: 60),

                  _buildTerms(),
                  const SizedBox(height: 10),
                  _buildLoginButton(),
                  const SizedBox(height: 10),
                  _buildRegisterTip(),
                  const SizedBox(height: 100),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Tool.setValue("access_token", "123456");
                  //     Navigator.pushNamed(context, mainPageRouteName);
                  //   },
                  //   child: const Text("Login"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
