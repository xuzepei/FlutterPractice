import 'package:flutter/material.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/util/route.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onBarItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      debugPrint("####: _onBarItemTap: $_selectedIndex");
    });
  }

  void _goToWelcomePage() {
    Navigator.pushNamed(context, welcomePageRouteName);
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
        appBar: AppBar(
          title: Text("Main Tab View"),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                debugPrint("#### clicked logout button");

                User.instance.logout();
                _goToWelcomePage();
              },
              child: Text("Log out")),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
            BottomNavigationBarItem(icon: Icon(Icons.email), label: "Email"),
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Camera")
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red, // Set the selected item color
          onTap: _onBarItemTap,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }


}
