import 'package:flutter/material.dart';
import 'package:panda_union/case/case_page.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/notifications/notification_page.dart';
import 'package:panda_union/services/service_page.dart';
import 'package:panda_union/settings/setting_page.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/workspace/workspace_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final Color _selectedItemColor = MyColors.systemBlue;
  final Color _unselectedItemColor = Colors.grey;
  final double _itemTextSize = 10;

  final List<Widget> _pages = <Widget>[
    CasePage(),
    WorkspacePage(),
    ServicePage(),
    NotificationPage(),
    SettingPage()
  ];

  final tabItems = [
    ("images/case.png", "Case"),
    ("images/workspace.png", "Workspace"),
    ("images/question.png", "Service"),
    ("images/bell.png", "Notification"),
    ("images/user.png", "Me"),
  ];

  @override
  void initState() {
    super.initState();

//以前登录的用户，需要刷新token
    User.instance.isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        User.instance.startTokenRefreshTimer();
      }
    });
  }

  void _onBarItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      debugPrint("####: _onBarItemTap: $_selectedIndex");
    });
  }

  @override
  Widget build(BuildContext context) {
    //Disable the splash and ripple effects
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Always show text
          items: [
            for (var item in tabItems)
              BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 30,
                    child: Image.asset(item.$1,
                        width: 24, color: _unselectedItemColor),
                  ),
                  activeIcon: SizedBox(
                    height: 30,
                    child: Image.asset(item.$1,
                        width: 24, color: _selectedItemColor),
                  ),
                  label: item.$2),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: _selectedItemColor, // Set the selected item color
          unselectedItemColor: _unselectedItemColor,
          selectedFontSize: _itemTextSize,
          unselectedFontSize: _itemTextSize,
          onTap: _onBarItemTap,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
