import 'package:flutter/material.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  const BottomNavigationBarDemo({super.key, required this.title});

  final String title;

  @override
  BottomNavigationBarDemoState createState() => BottomNavigationBarDemoState();
}

class BottomNavigationBarDemoState extends State<BottomNavigationBarDemo> {
  int _selectedIndex = 0;

  void _onBarItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      debugPrint("####: _onBarItemTap: $_selectedIndex");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: "Email"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Camera")
        ],
        backgroundColor: Colors.white,
        onTap: _onBarItemTap,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
