import 'package:flutter/material.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/util/route.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  final ScrollController _scrollController = ScrollController();
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      debugPrint('#### Scroll offset: ${_scrollController.offset}');

      setState(() {
        // Adjust opacity based on scroll position
        _opacity = (_scrollController.offset / 50).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goToWelcomePage() {
    Navigator.pushNamed(context, welcomePageRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustom.buildAppBar("Settings", _opacity, context, null, true),
      body: SafeArea(
          child: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                debugPrint("#### clicked logout button");

                User.instance.logout();
                _goToWelcomePage();
              },
              child: Text("Log out")),
        ),
      )),
    );
  }
}
