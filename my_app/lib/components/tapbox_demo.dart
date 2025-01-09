import 'package:flutter/material.dart';

class TapBox extends StatelessWidget {
  TapBox(
      {super.key,
      required this.title,
      required this.isActive,
      required this.onChanged});

  String title;
  bool isActive;
  ValueChanged<bool> onChanged;

  void handleTap() {
    onChanged(!isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        color: isActive ? Colors.red : Colors.grey,
        width: 160,
        height: 160,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              Text(
                isActive ? 'Active' : 'Inactive',
                style: const TextStyle(fontSize: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TapBoxDemo extends StatefulWidget {
  const TapBoxDemo({super.key, required this.title});

  final String title;

  @override
  TapBoxDemoState createState() => TapBoxDemoState();
}

class TapBoxDemoState extends State<TapBoxDemo> {
  bool _activeA = false;
  bool _activeB = false;

  void _handleTapboxAValueChanged(bool value) {
    setState(() {
      _activeA = value;
    });
  }

  void _handleTapboxBValueChanged(bool value) {
    setState(() {
      _activeB = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TapBox(
              title: "TapBoxA",
              isActive: _activeA,
              onChanged: _handleTapboxAValueChanged),
          TapBox(
              title: "TapBoxB",
              isActive: _activeB,
              onChanged: _handleTapboxBValueChanged),
        ],
      ),
    );
  }
}
