import 'package:flutter/material.dart';

class PageViewDemo extends StatefulWidget {
  PageViewDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return PageViewDemoState();
  }
}

class PageViewDemoState extends State<PageViewDemo> {
  var pages = <Page>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < 6; ++i) {
      pages.add(Page(text: '$i'));
    }

    //1，2页缓存
    pages[1].needToCache = true;
    pages[2].needToCache = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        children: pages,
        scrollDirection: Axis.vertical,
        allowImplicitScrolling: false,
      ),
    );
  }
}

class Page extends StatefulWidget {
  Page({super.key, required this.text});
  final String text;
  var needToCache = false;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PageState();
  }
}

class PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用

    debugPrint("####: Page build: ${widget.text}");
    return Center(
      child: Text(
        widget.text,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 100, color: Colors.grey),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive {
    return widget.needToCache;
  } // 返回 true 以保持状态
}
