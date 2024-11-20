import 'package:flutter/material.dart';
import 'package:my_app/common/keep_alive_wrapper.dart';

class TabBarViewDemo extends StatefulWidget {
  TabBarViewDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return TabBarViewDemoState();
  }
}

class TabBarViewDemoState extends State<TabBarViewDemo> {
  List _tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
              labelStyle: TextStyle(fontSize: 16, color: Colors.black), //选中时的文字显示，解决选中时文字看不见的问题
              indicatorColor: Colors.red,
              unselectedLabelStyle: TextStyle(fontSize: 14),
              tabs: _tabs.map((e) {
            return Tab(text: e);
          }).toList()),
        ),
        body: TabBarView(
            children: _tabs.map((e) {
          return Builder(
            builder: (context) {
              debugPrint("####: build: $e");
              return KeepAliveWrapper(
                //needToKeep: false,
                child: Container(
                  color: Colors.white,
                  child: Center(
                      child: Text(e,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 60))),
                ),
              );
            }
          );
        }).toList()),
      ),
    );
  }
}
