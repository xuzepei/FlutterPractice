import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panda_union/common/button.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/common/dialog.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';
import 'package:panda_union/util/url_config.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Dio _dio = Dio();
  var _isLoading = false;

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

  final ScrollController _scrollController = ScrollController();
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      debugPrint('#### Scroll offset: ${_scrollController.offset}');

      setState(() {
        // Adjust opacity based on scroll position
        _opacity = (_scrollController.offset / 50).clamp(0.0, 1.0);
      });
    });
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

    _scrollController.dispose();

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
            padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
            child: Text(
              _passwordInputError,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

          MyButton.buildTextButton(
              onPressed: () {
                debugPrint("#### Forgot password");
              },
              text: "Forgot password?"),
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
                  WidgetSpan(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      splashColor: MyColors.systemGray6,
                      highlightColor: MyColors.systemGray6,
                      onTap: () {
                        debugPrint("#### Terms of Service");

                        _goToWebViewPage("Terms of Service",
                            "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/");
                      },
                      child: Text(
                        "Terms of Service",
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  TextSpan(text: " and "),
                  WidgetSpan(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      splashColor: MyColors.systemGray6,
                      highlightColor: MyColors.systemGray6,
                      onTap: () {
                        debugPrint("#### Privacy Policy");
                      },
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
            child: MyButton.build(
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

    bool b = _accountFormKey.currentState!.validate();
    if (b == false) {
      return;
    }

    String account = _accountController.text;
    String password = _passwordController.text;
    if (account.isNotEmpty && password.isNotEmpty) {
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(TextSpan(text: "Don't have an account? ", children: [
          WidgetSpan(
            child: MyButton.buildTextButton(
                onPressed: () {
                  debugPrint("#### clicked Register");
                  _goToRegisterPage();
                },
                text: "Register",
                textStyle: TextStyle(
                    fontSize: 16,
                    color: MyColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: MyColors.primaryColor,
                    decorationThickness: 1.0,
                    fontWeight: FontWeight.w500)),
          ),
        ])),
      ],
    );
  }

  void _goToRegisterPage() {
    Navigator.pushNamed(context, registerPageRouteName);
  }

  void _goToWebViewPage(String title, String url) {
    Navigator.pushNamed(context, webViewPageRouteName, arguments: {
      "title": title,
      "url": url,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Opacity(
      //     opacity: _opacity,
      //     child: Text("Login"),
      //   ),
      //   //systemOverlayStyle: SystemUiOverlayStyle.dark,
      //   elevation: 0.0,
      //   shadowColor: MyColors.appBarShadowColor,
      //   surfaceTintColor: Colors.transparent,
      //   backgroundColor: Colors.white,
      //   leading: MyButton.appBarLeadingButton(context),
      // ),
      appBar: MyCustom.buildAppBar("Login", _opacity, context, null),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<int> _login() async {
    void onAPIHostSuccess() {
      debugPrint("#### getAPIHost success.");

      setState(() {
        _isLoading = false; // 关闭加载动画
      });
    }

    void onAPIHostError(String? msg) {
      debugPrint("#### getAPIHost error: $msg");

      setState(() {
        _isLoading = false; // 关闭加载动画
      });
    }

    setState(() {
      _isLoading = true; // 显示加载动画
    });

    String errorMsg = "Sorry, an unexpected error has occurred.";

    try {
      _dio.options.baseUrl =
          UrlConfig.instance.getBaseUrl(UrlConfig.instance.region);
      String urlString = "/common/services";

      Response response = await _dio.get(urlString);
      if (response.statusCode == 200) {
        debugPrint("#### getAPIHost success");
        debugPrint("#### getAPIHost: ${response.data?.runtimeType}");
        debugPrint("#### getAPIHost: ${response.data}");

        if (response.data is Map) {
          Map<String, dynamic> data = response.data;
          if (data.containsKey("success")) {
            dynamic success = data["success"];
            if (success is bool && success) {
              if (data.containsKey("data")) {
                dynamic dataDict = data["data"];
                if (dataDict is Map) {
                  Tool.setValue("${region}_$api_host_key", dataDict);
                  onAPIHostSuccess();
                  return 0;
                }
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint("#### getAPIHost error: $e");
    } finally {}

    onAPIHostError(errorMsg);
    return -1;
  }
}
