import 'package:flutter/material.dart';

class ComponentTextField extends StatefulWidget {
  const ComponentTextField({super.key});

  @override
  State<ComponentTextField> createState() {
    return ComponentTextFieldState();
  }
}

class ComponentTextFieldState extends State<ComponentTextField> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode usernameFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusScopeNode? focusScopeNode;


  GlobalKey formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameController.text = "ABC";

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
        title: const Text("TextField"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                controller: usernameController,
                focusNode: usernameFN,
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Username or email",
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                autofocus: false,
                obscureText: true,
                controller: passwordController,
                focusNode: passwordFN,
                decoration: InputDecoration(
                    labelText: null,
                    hintText: "••••••",
                    prefixIcon: Icon(Icons.lock),
                    border: InputBorder.none),
              ),
              TextField(
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                    labelText: "Grey underline",
                    hintText: "Input 1",
                    prefixIcon: Icon(Icons.mail),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(onPressed: () {
                    FocusScope.of(context).requestFocus(passwordFN);
                  }, child: Text("Move Focus")),
                  ElevatedButton(onPressed: () {
                    usernameFN.unfocus();
                    passwordFN.unfocus();
                  }, child: Text("Hide Keyboard"))
                ],
              ),
                            SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
