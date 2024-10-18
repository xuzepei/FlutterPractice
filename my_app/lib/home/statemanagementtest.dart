import 'package:flutter/material.dart';

class TapBoxesStatelessParent extends StatelessWidget {
  const TapBoxesStatelessParent({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TapBoxA(),
    );
  }
}

class TapBoxA extends StatefulWidget {
  const TapBoxA({super.key});

  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _isActive = false;

  void handleTap() {
    print("####: _TapBoxAState.handleTap");
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 100,
        height: 100,
        decoration:
            BoxDecoration(color: _isActive ? Colors.green : Colors.grey),
        child: Center(
          child: Text(_isActive ? 'Active' : 'Inactive'),
        ),
      ),
    );
    // TODO: implement build
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("initState ");
  }
}

class TapBoxesStatefulParent extends StatefulWidget {
  const TapBoxesStatefulParent({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _TapBoxesStatefulParentState();
  }
}

class _TapBoxesStatefulParentState extends State<TapBoxesStatefulParent> {

  bool _isActiveA = false;
  bool _isActiveB = false;

  void handleTapBoxChanged( bool newValue) {
    print("####: _TapBoxesStatefulParentState.handleTapBoxChanged");
    setState(() {
      _isActiveB = !_isActiveB;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TapBoxB(
        isActive: _isActiveB,
        onChanged: handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxB extends StatelessWidget {
  const TapBoxB({super.key, this.isActive=false, required this.onChanged});

  final bool isActive;
  final ValueChanged<bool> onChanged;

  void handleTap() {
    print("####: TapBoxB.handleTap");
    onChanged(!isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 100,
        height: 100,
        decoration:
        BoxDecoration(color: isActive ? Colors.red : Colors.black),
        child: Center(
          child: Text(isActive ? 'Active' : 'Inactive', style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      ),
    );
    // TODO: implement build
  }
}
