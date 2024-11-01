import 'package:flutter/material.dart';
import 'package:my_app/util/tool.dart';

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
      debugPrint("username: $value");
    });

    passwordController.addListener(() {
      var value = passwordController.text;
      debugPrint("password: $value");
    });

    usernameFN.addListener(() {
      debugPrint("usernameFN.hasFocus: " + usernameFN.hasFocus.toString());
    });

    passwordFN.addListener(() {
      debugPrint("passwordFN.hasFocus: " + passwordFN.hasFocus.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
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
                      errorText: null,
                      labelText: "Username",
                      hintText: "Username or email",
                      prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if(!isEmptyOrNull(value)) {
                          return null;
                        } else {
                          return "The username can not be empty!";
                        }
                      },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: false,
                  obscureText: true,
                  controller: passwordController,
                  focusNode: passwordFN,
                  // decoration: InputDecoration(
                  //   labelText: "Password",
                  //   hintText: "••••••",
                  //   prefixIcon: Icon(Icons.lock),
                  // ),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      errorText: null,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: "",
                      hintText: "",
                      prefixIcon: Icon(Icons.smartphone, color: Colors.grey,)),
                  validator: (value) {
                        if(value!.trim().length > 5) {
                          return null;
                        } else {
                          return "The password must contain 6 characters at least!";
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
                        debugPrint("Pressed login button.");
                        //点击登录按钮后，先判断用户名和密码是否有效
                        FormState formState = formKey.currentState as FormState;
                        //FormState formState = Form.of(context); //这样不行，context不对
                        if (formState.validate()) {
                          debugPrint("is valid!");
                        } else {
                          debugPrint("is invalid!");
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
