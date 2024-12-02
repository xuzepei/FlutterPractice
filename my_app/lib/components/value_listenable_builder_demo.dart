import 'package:flutter/material.dart';

class ValueListenableBuilderDemo extends StatefulWidget {
  const ValueListenableBuilderDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ValueListenableBuilderDemoState();
  }
}

class ValueListenableBuilderDemoState
    extends State<ValueListenableBuilderDemo> {
  // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  int _count = 0;

  @override
  Widget build(BuildContext context) {

    debugPrint("####: build parent.");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ValueListenableBuilder(
            child: Text("Using ValueListenableBuilder: "),
            valueListenable: _counter,
            builder: (BuildContext context, int value, Widget? child) {
              debugPrint("####: build child.");
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Using setState: "),
                        Text('$_count times', textScaleFactor: 1.5),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        child!,
                        Text('$value times', textScaleFactor: 1.5),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          //通过setState来修改count,则整个widget都会重建，效率相对较低
          // setState(() {
          //   _count++;
          // });

          //通过ValueNotifier来修改count值，则只用刷新子widget，效率相对较高
          _counter.value += 1;

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
