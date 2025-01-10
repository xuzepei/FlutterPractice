import 'package:flutter/material.dart';
import 'package:panda_union/login/login_view.dart';
import 'package:panda_union/main_tab_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  //路由生成钩子, 方便根据命名统一做处理：比如判断是否要求登录
  Route<dynamic> createRoute(RouteSettings settings) {
    
    bool isLoggedIn = false;

    if (!isLoggedIn) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return const LoginView();
        },
      );
    }

    return MaterialPageRoute(
      builder: (BuildContext context) {
        Widget willShowWidget;
        String routeName = settings.name ?? "/";
        if (routeName == "/") {
          willShowWidget = MainTabView();
        } else {
          willShowWidget = const LoginView();
        }

        return willShowWidget;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => MainTabView(),
      // },
      title: "Panda Union",
      theme: ThemeData(
        primaryColor: Colors.blue, // Set the primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange, // Set the accent color
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Set the AppBar color
        ),
      ),
      onGenerateRoute: createRoute,
      //home: MainTabView(),
    );
  }
}
