import 'package:flutter/material.dart';
import 'package:panda_union/login/login_page.dart';
import 'package:panda_union/main_page.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';

Future<void> main() async {
  //初始化用户信息
  WidgetsFlutterBinding.ensureInitialized();
  await User.instance.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: User.navigatorKey,
      // initialRoute: "/",
      // routes: {
      //   "/": (context) => MainTabView(),
      // },
      title: appName,
      theme: ThemeData(
        primaryColor: MyColors.primaryColor, // Set the primary color

        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: MyColors.primaryColor, //TextField cursor color
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
