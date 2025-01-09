import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  CounterWidget({super.key, required this.title, this.initValue = 0});

  final String title;
  final int initValue;

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void reset() {
    setState(() {
      _count = 0;
    });
  }

  void increase() {
    setState(() {
      _count++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = widget.initValue;

    debugPrint("####: initState, _count: $_count");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("####: _CounterWidgetState.build");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            debugPrint("####: clicked increase button."),
                            increase()
                          },
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                      //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      // ),
                      child: const Text("Increase")),
                  const SizedBox(width: 16), //span
                  Text(
                    "Count: $_count",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    debugPrint("####: clicked button.");

                    //1. context对象有一个findAncestorStateOfType()方法
                    ScaffoldState? temp =
                        context.findAncestorStateOfType<ScaffoldState>();

                    //2. 直接通过of静态方法来获取ScaffoldState
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("我是SnackBar")),
                    );

                    //3. 通过GlobalKey来获取State对象
                  },
                  child: const Text("在 widget 树中获取State对象")),
            ],
          ),
        ),
      ),
    );
    // Material is a conceptual piece
    // of paper on which the UI appears.
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    debugPrint("####: _CounterWidgetState.didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    debugPrint("####: _CounterWidgetState.deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint("####: _CounterWidgetState.dispose");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    reset();

    //hot update 时调用
    debugPrint("####: _CounterWidgetState.reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("####: _CounterWidgetState.didChangeDependencies");
  }
}
