import 'package:flutter/material.dart';

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
