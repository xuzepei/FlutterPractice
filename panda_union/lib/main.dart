import 'package:flutter/material.dart';
import 'package:panda_union/login/login_page.dart';
import 'package:panda_union/main_page.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/util/route.dart';

const appName = "Panda Union";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => MainTabView(),
      // },
      title: appName,
      theme: ThemeData(
        primaryColor: Colors.blue, // Set the primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange, // Set the accent color
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Set the AppBar color
        ),
      ),
      onGenerateRoute: generateRoute,
      //home: MainTabView(),
    );
  }
}
