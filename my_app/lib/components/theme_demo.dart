import 'package:flutter/material.dart';

class ThemeDemo extends StatefulWidget {
  ThemeDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ThemeDemoState();
  }
}

class ThemeDemoState extends State<ThemeDemo> {
  var themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
        data: ThemeData(
          primarySwatch: themeColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: themeColor, // Set the background color
            foregroundColor: Colors.white, // Set the icon/text color
          ),
          iconTheme: IconThemeData(color: themeColor), //用于Icon颜色
          appBarTheme: AppBarTheme(
            backgroundColor: themeColor, // Set the AppBar color
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //第一行Icon使用主题中的iconTheme
              Row(
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text(" 颜色跟随主题")
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              SizedBox(
                height: 40,
              ),

              //为第二行Icon自定义颜色（固定为黑色)
              Theme(
                data: themeData,
                child: Row(
                  children: [
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text(" 颜色固定黑色")
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            setState(() {
              themeColor = themeColor == Colors.teal ? Colors.blue:Colors.teal;
            });
          }, child: Icon(Icons.palette),),
        ),
    );
  }
}
