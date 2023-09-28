import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(wordPair.toString()),
    );
  }
}

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    //...省略无关代码

    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("Arguments are $args"),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  String? text;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("$args"),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回值😀😀😀"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future goToNextPage() async {
    // 打开`TipRoute`，并等待返回结果
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TipRoute(
              // 路由参数
              //text: "测试路由传值: 123456",
              );
        },
      ),
    );
    //输出`TipRoute`路由返回结果
    print("路由返回值: $result");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            Builder(builder: (context) {
              return Column(
                children: [
                  RandomWordsWidget(),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("我是SnackBar")),
                      );
                    },
                    child: Text('显示SnackBar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                        try {
                            dynamic foo = true;
                            print(foo++); // Runtime error
                          } catch (e) {
                            print('Error: $e');
                            //rethrow; // Allow callers to see the exception.
                          }
                      },
                      child: Text("Try/Catch")
                  ),
                  ElevatedButton(
                      onPressed: goToNextPage, child: Text("New Route")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "new_page");
                      },
                      child: Text("通过路由名称来打开路由")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "new_page_with_args",
                            arguments: ["hi", 666]);
                      },
                      child: Text("命名路由带参数")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "tip_page_with_args",
                            arguments: "hi tip");
                      },
                      child: Text("TipPage命名路由带参数")),
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = 0;

    print("initState ");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("didUpdateWidget ");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    print("deactivate ");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print("dispose ");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();

    print("reassemble ");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    print("didChangeDependencies ");
  }
}
