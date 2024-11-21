import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatefulWidget {
  CustomScrollViewDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomScrollViewDemoState();
  }
}

class CustomScrollViewDemoState extends State<CustomScrollViewDemo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildTwoSliverList(),
    );
  }

  Widget buildTwoListView() {
    var listView = ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          debugPrint("#### index: $index");
          return ListTile(
            title: Text("$index"),
          );
        });

    return Column(
      children: [
        Expanded(child: listView),
        Divider(color: Colors.grey),
        Expanded(child: listView)
      ],
    );
  }

  Widget buildTwoSliverList() {
    // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
    // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
    // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(title: Text("$index"));
    }, childCount: 10), itemExtent: 56);

    return CustomScrollView(slivers: [
      listView,
      listView,
    ],);
  }
}
