import 'package:flutter/material.dart';
import 'package:panda_union/common/not_found_page.dart';
import 'package:panda_union/common/webview_page.dart';
import 'package:panda_union/login/login_page.dart';
import 'package:panda_union/login/register_page.dart';
import 'package:panda_union/login/welcome_page.dart';
import 'package:panda_union/main_page.dart';
import 'package:panda_union/models/user.dart';

const rootRouteName = "/";
const welcomePageRouteName = "welcome_page";
const loginPageRouteName = "login_page";
const registerPageRouteName = "register_page";
const mainPageRouteName = "main_page";
const notFoundPageRouteName = "not_found_page";
const webViewPageRouteName = "webview_page";

//路由生成钩子, 方便根据命名统一做处理：比如判断是否要求登录
Route<dynamic> generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
//To pass settings (such as custom data or arguments) to a MaterialPageRoute, you can use the settings parameter of the route. This is typically done by using the RouteSettings class, which allows you to pass data like the route name, arguments, and other information when pushing the route.
//Here's how you can do it:
//Define your arguments/data that you want to pass to the new page.
//Use RouteSettings to pass data when creating a MaterialPageRoute.
//Access the passed arguments in the destination page (inside onGenerateRoute or directly using ModalRoute.of(context)).

    settings: RouteSettings(arguments: settings.arguments),
    builder: (BuildContext context) {
      String routeName = settings.name ?? rootRouteName;

      //通过Navigator.pushNamed方法传递来的路由参数
      final args = settings.arguments as Map<String, String>? ?? {};
      debugPrint("#### Route arguments: $args");

      return FutureBuilder<bool>(
        future: User.instance.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            debugPrint("#### createRoute, error: ${snapshot.error}");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint("#### createRoute, waiting...");

            //return NotFoundPage();
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data == true) {
            debugPrint("#### createRoute, isLoggedIn: ${snapshot.data}");

            switch (routeName) {
              case rootRouteName:
                return MainPage();
              case loginPageRouteName:
                return MainPage();
              case mainPageRouteName:
                return MainPage();
              default:
                return NotFoundPage();
            }
          } else if (snapshot.hasData) {
            switch (routeName) {
              case loginPageRouteName:
                return LoginPage();
              case registerPageRouteName:
                return RegisterPage();
              case webViewPageRouteName:
                return WebViewPage();
              default:
                {
                  break;
                }
            }
          }

          return WelcomePage();
        },
      );
    },
  );
}
