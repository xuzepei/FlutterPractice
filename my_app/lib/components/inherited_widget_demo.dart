import 'package:flutter/material.dart';

class InheritedWidgetDemo extends StatefulWidget {
  InheritedWidgetDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return InheritedWidgetDemoState();
  }
}

class InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int count = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    debugPrint("####: didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ShareDataWidget(
        data: count,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TestWidget(),
              //context 必须是 ShareDataWidget 子树的构建上下文, 所以不能用 Widget build(BuildContext context)中的context,而需要建立子组件包裹一下
              Builder(builder: (context) {
                return Text(ShareDataWidget.of(context)!.data.toString());
              }),
              //Text("使用ShareDataWidget中的data变量: ${ShareDataWidget.of(context)!.data.toString()}"),
              Text("使用count变量: $count", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: () {
                    debugPrint("####: tap add button! ");
                    setState(() {
                      count++;
                    });
                  },
                  child: Icon(Icons.add, color: Colors.white,),
                  style: ButtonStyle(
                      backgroundColor:
                      WidgetStatePropertyAll(Colors.blue.withOpacity(1.0))))
            ],
          ),
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({required super.child, required this.data});

  final int data; //需要在子树中共享的数据，保存点击次数

  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.data != data;
  }

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    debugPrint("####: Dependencies change 222222 ");
  }
}
