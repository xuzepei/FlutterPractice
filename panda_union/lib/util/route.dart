import 'package:flutter/material.dart';
import 'package:panda_union/common/not_found_page.dart';
import 'package:panda_union/login/login_page.dart';
import 'package:panda_union/login/welcome_page.dart';
import 'package:panda_union/main_page.dart';
import 'package:panda_union/models/user.dart';

const rootRouteName = "/";
const welcomePageRouteName = "welcome_page";
const loginPageRouteName = "login_page";
const mainPageRouteName = "main_page";
const notFoundPageRouteName = "not_found_page";

//路由生成钩子, 方便根据命名统一做处理：比如判断是否要求登录
Route<dynamic> generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      String routeName = settings.name ?? rootRouteName;

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
