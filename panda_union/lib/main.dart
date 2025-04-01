import 'package:flutter/material.dart';
import 'package:panda_union/common/keys.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/providers/network_provider.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/route.dart';
import 'package:panda_union/common/tool.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //初始化用户信息
  WidgetsFlutterBinding.ensureInitialized();
  NetworkProvider();
  await User.instance.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NetworkProvider()),
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Keys.navigatorKey,
      scaffoldMessengerKey: Keys.scaffoldMessengerKey,
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
