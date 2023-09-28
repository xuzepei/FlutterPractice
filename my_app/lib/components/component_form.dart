import 'package:flutter/material.dart';

class ComponentForm extends StatefulWidget {
  const ComponentForm({super.key});

  @override
  State<ComponentForm> createState() {
    return ComponentFormState();
  }
}

class ComponentFormState extends State<ComponentForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode usernameFN = FocusNode();
  FocusNode passwordFN = FocusNode();

  GlobalKey formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameController.addListener(() {
      var value = usernameController.text;
      print("username: $value");
    });

    passwordController.addListener(() {
      var value = passwordController.text;
      print("password: $value");
    });

    usernameFN.addListener(() {
      print("usernameFN.hasFocus: " + usernameFN.hasFocus.toString());
    });

    passwordFN.addListener(() {
      print("passwordFN.hasFocus: " + passwordFN.hasFocus.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: usernameController,
                  focusNode: usernameFN,
                  decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Username or email",
                      prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if(value!.trim().isNotEmpty) {
                          return null;
                        } else {
                          return "The username can not be empty!";
                        }
                      },
                ),
                TextFormField(
                  autofocus: false,
                  obscureText: true,
                  controller: passwordController,
                  focusNode: passwordFN,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "••••••",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                        if(value!.trim().length > 5) {
                          return null;
                        } else {
                          return "The password must constain 6 characters at least!";
                        }
                      },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center, //使左对齐的Column中的Button居中，办法是将Button放在Container里
                  child: ElevatedButton(
                      onPressed: () {
                        print("Pressed login button.");
                        //点击登录按钮后，先判断用户名和密码是否有效
                        FormState formState = formKey.currentState as FormState;
                        if (formState.validate()) {
                          print("is valid!");
                        } else {
                          print("is invalid!");
                        }

                        //formState.reset();
                      },
                      child: Text("Login")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
