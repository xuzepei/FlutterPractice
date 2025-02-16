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
  int _selectedIndex = 0; // 0: 用户名登录, 1: 手机号登录
  final _formKey = GlobalKey<FormState>();

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
  String _phoneInputError = "";
  String _codeInputError = "";

  bool _obscurePassword = true;

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
    return Column(
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
                _accountInputError = "Please enter your account";
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
        _obscurePassword ? 'images/close_eye.png':'images/open_eye.png', // Path to your local image
        width: 25, // Set the width of the icon
        height: 25, // Set the height of the icon
      ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                }
              )),
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
                _passwordInputError = "Please enter your password";
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
      ],
    );
  }

  Widget _buildPhoneLogin() {
    return Column(
      children: [
        TextFormField(
          controller: _phoneController,
          focusNode: _phoneFocus,
          decoration: const InputDecoration(
            labelText: "Phone",
            hintText: "Please enter your phone number",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your phone number";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _codeController,
                focusNode: _codeFocus,
                decoration: const InputDecoration(
                  labelText: "Code",
                  hintText: "Please enter the verification code",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the verification code";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Get Code"),
            ),
          ],
        ),
      ],
    );
  }

  void _submitAccountForm() {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.validate();

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
                      : _submitAccountForm();

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
                },
                text: "Login"),
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 0),
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

                    const SizedBox(height: 100),
                    _buildLoginButton(),

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
      ),
    );
  }
}
