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

//TapBoxA自己管理自己的状态例子, TapBoxA自己是stateful
class TapBoxA extends StatefulWidget {
  const TapBoxA({super.key});

  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _isActive = false;

  void handleTap() {
    debugPrint("####: _TapBoxAState.handleTap");
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 160,
        height: 160,
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

    debugPrint("initState ");
  }
}

//TapBoxB的状态由它的父类管理的例子，父类是stateful， TapBoxB自己是stateless
class TapBoxesStatefulParent extends StatefulWidget {
  const TapBoxesStatefulParent({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _TapBoxesStatefulParentState();
  }
}

class _TapBoxesStatefulParentState extends State<TapBoxesStatefulParent> {
  bool _isActiveB = false;
  bool _isActiveC = false;

  void handleTapBoxBChanged( bool newValue) {
    debugPrint("####: _TapBoxesStatefulParentState.handleTapBoxChanged");
    setState(() {
      _isActiveB = !_isActiveB;
    });
  }

  void handleTapBoxCChanged( bool newValue) {
    debugPrint("####: _TapBoxesStatefulParentState.handleTapBoxChanged");
    setState(() {
      _isActiveC = !_isActiveC;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TapBoxB(
            isActive: _isActiveB,
            onChanged: handleTapBoxBChanged,
          ),
          SizedBox(width: 40),
          TapBoxC(
            isActive: _isActiveC,
            onChanged: handleTapBoxCChanged,
          ),
        ],
      ),
    );
  }
}

class TapBoxB extends StatelessWidget {
  const TapBoxB({super.key, this.isActive=false, required this.onChanged});

  final bool isActive;
  final ValueChanged<bool> onChanged;

  void handleTap() {
    debugPrint("####: TapBoxB.handleTap");
    onChanged(!isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: 160,
        height: 160,
        decoration:
        BoxDecoration(color: isActive ? Colors.red : Colors.black),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("TapBox B", style: TextStyle(fontSize: 20, color: Colors.white),),
              Text(isActive ? 'Active' : 'Inactive', style: TextStyle(fontSize: 20, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
    // TODO: implement build
  }
}

//TapBoxC和它父类是混合管理状态，都是Stateful的
class TapBoxC extends StatefulWidget {
  const TapBoxC({super.key, this.isActive=false, required this.onChanged});

  final bool isActive;
  final ValueChanged<bool> onChanged;

  void handleTap() {
    debugPrint("####: TapBoxC.handleTap");
    onChanged(!isActive);
  }

  @override
  State<StatefulWidget> createState() {
    return _TapBoxCState();
  }
}

class _TapBoxCState extends State<TapBoxC> {

  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.handleTap,
      child: Container(
        width: 160,
        height: 160,
        decoration:
        BoxDecoration(color: widget.isActive ? Colors.red : Colors.black, border: _highlight ? Border.all(color: Colors.teal, width: 10.0) : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("TapBox C", style: TextStyle(fontSize: 20, color: Colors.white),),
            Text(widget.isActive ? 'Active' : 'Inactive', style: TextStyle(fontSize: 20, color: Colors.white),),
          ],
        ),
      ),
    );
    // TODO: implement build
  }

}

