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
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
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
        onPressed: () => {
          print("####: clicked float action button.")
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
