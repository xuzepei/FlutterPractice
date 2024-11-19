import 'package:flutter/material.dart';

class AnimatedListDemo extends StatefulWidget {
  AnimatedListDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnimatedListDemoState();
  }
}

class AnimatedListDemoState extends State<AnimatedListDemo> {
  var _data = <String>[];
  int _count = 5;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < _count; i++) {
      _data.add("${i + 1}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Scrollbar(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (context, index, animation) {
                //添加列表项时会执行渐显动画
                return FadeTransition(
                    opacity: animation, child: MyListItem(context, index));
              },),
          ),
          AddItemButton(),
        ],
      ),
    );
  }

  Widget AddItemButton() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: FloatingActionButton(onPressed: () {
          debugPrint("####: clicked add item button");
          _count++;
          _data.add("$_count");
          _listKey.currentState?.insertItem(_data.length - 1);
        }, child: Icon(Icons.add)),
      ),
    );
  }

  //构建列表项
  Widget MyListItem(context, index) {
    String text = _data[index];
    return ListTile(
      //key: ValueKey(index),
      title: Text(text),
      trailing: IconButton(onPressed: () {
        deleteItem(context, index);
      }, icon: Icon(Icons.delete)),
    );
  }

  void deleteItem(context, index) {
    debugPrint("####: delete item: $index");

    _listKey.currentState?.removeItem(index, (context, animation) {
      var item = MyListItem(context, index);
      _data.removeAt(index);
      return FadeTransition(opacity: animation,
        child: SizeTransition(
          sizeFactor: animation, axisAlignment: 0, child: item,));
    }, duration: Duration(milliseconds: 200));
  }
}
