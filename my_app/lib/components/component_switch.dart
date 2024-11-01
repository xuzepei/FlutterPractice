import 'package:flutter/material.dart';

class ComponentSwitch extends StatefulWidget {
  const ComponentSwitch({super.key});

  @override
  State<ComponentSwitch> createState() {
    return ComponentSwitchState();
  }
}

class ComponentSwitchState extends State<ComponentSwitch> {
  bool switchSelected = false;
  bool checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Switch & Checkbox"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //3.3.1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "3.4.1 Switch",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Switch(
                      value: switchSelected,
                      onChanged: (value) {
                        setState(() {
                          switchSelected = value;
                          debugPrint("####: switchSelected is $switchSelected");
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "3.4.2 Checkbox",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Checkbox(
                      value: checkboxSelected,
                      onChanged: (value) {
                        setState(() {
                          checkboxSelected = value ?? false;
                          debugPrint("####: checkboxSelected is $checkboxSelected");
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
