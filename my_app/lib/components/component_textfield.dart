import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


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

  String _errorText = "";

  //FocusScopeNode? focusScopeNode;
  //GlobalKey formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameController.text = "ABC";

    usernameController.addListener(() {
      var value = usernameController.text;
      debugPrint("#### username: $value");
    });

    passwordController.addListener(() {
      var value = passwordController.text;
      debugPrint("#### password: $value");
    });

    usernameFN.addListener(() {
      debugPrint("#### usernameFN.hasFocus: " + usernameFN.hasFocus.toString());
    });

    passwordFN.addListener(() {
      debugPrint("#### passwordFN.hasFocus: " + passwordFN.hasFocus.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField"),
        //修改返回按钮
        leading: IconButton(onPressed: () {
          debugPrint("#### clicked back arrow");
          FocusScope.of(context).unfocus();
          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.of(context).pop();
          });
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //username
              TextField(
                autofocus: true,
                controller: usernameController,
                focusNode: usernameFN,
                // onChanged: (v) {
                //   debugPrint("#### username is $v");
                // },
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Username or email",
                    prefixIcon: Icon(Icons.person)),
              ),
              //password
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
              //email
              TextField(
                autofocus: false,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Grey underline",
                    hintText: "Input 1",
                    prefixIcon: Icon(Icons.mail),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red))),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Custom TextField",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              //phone
              TextField(
                autofocus: false,
                obscureText: false,
                onChanged: (v) {
                  setState(() {
                    _errorText = v.length > 11?"The phone number is too long!":"";
                  });
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9+\-\s]*$')),],
                cursorColor: Colors.blue,
                cursorErrorColor: Colors.red,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    errorText: (_errorText.length == 0)? null:_errorText,
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
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(passwordFN);
                      },
                      child: Text("Move Focus")),
                  ElevatedButton(
                      onPressed: () {
                        usernameFN.unfocus();
                        passwordFN.unfocus();
                      },
                      child: Text("Hide Keyboard")),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("####: password: " + usernameController.text);
                    },
                    child: Text("Get input text of password"),
                  )
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

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    debugPrint("#### deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    debugPrint("#### dispose");
  }
}
