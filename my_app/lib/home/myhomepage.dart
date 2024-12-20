import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

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

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New page"),
      ),
      body: Center(
        child: Text("This is a new page"),
      ),
    );
  }
}

class TipPage extends StatelessWidget {
  TipPage({super.key, required this.text});

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
              Text(text ?? 'No argument'),
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

  Future goToTipPage() async {
    // 打开`TipRoute`，并等待返回结果
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TipPage(
              // 路由参数
              text: "测试路由传值: 123456",
              );
        },
      ),
    );
    //输出`TipPage`路由返回结果
    debugPrint("####: 路由返回值: $result");
  }

  Future goToTipPageAndGetBackResult() async {
    // 打开`TipRoute`，并等待返回结果
    var result = await Navigator.pushNamed(context, "tip_page",
        arguments: "hi tip");
    //输出`TipPage`路由返回结果
    debugPrint("####: 路由返回值: $result");
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
                    debugPrint(foo++); // Runtime error
                  } catch (e) {
                    debugPrint('Error: $e');
                    //rethrow; // Allow callers to see the exception.
                  }
                },
                child: Text("Try/Catch")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewPage();
                  }));
                }, child: Text("Open New Route")

            ),
            ElevatedButton(
                onPressed: goToTipPage, child: Text("Open Tip Route")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "new_page");
                },
                child: Text("通过路由名称来打开路由")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "echo_route",
                      arguments: ["hi", 666]);
                },
                child: Text("命名路由带参数")),
            ElevatedButton(
                onPressed: goToTipPageAndGetBackResult,
                child: Text("TipPage命名路由带参数")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          debugPrint("####: clicked float action button.")
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

    debugPrint("initState ");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    debugPrint("didUpdateWidget ");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

    debugPrint("deactivate ");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    debugPrint("dispose ");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();

    debugPrint("reassemble ");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    debugPrint("didChangeDependencies ");
  }
}
