import 'package:flutter/material.dart';

class SliversDemo extends StatefulWidget {
  SliversDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SliversDemoState();
  }
}

class SliversDemoState extends State<SliversDemo> {
  ScrollController _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;
  double _titleOpacity = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      debugPrint("####: offset: $offset");

      if (_scrollController.offset > 120 && !_isAppBarCollapsed) {
        setState(() {
          _isAppBarCollapsed = true;
          _titleOpacity = 1.0;
        });
      } else if (_scrollController.offset <= 120 && _isAppBarCollapsed) {
        setState(() {
          _isAppBarCollapsed = false;
          _titleOpacity = 0.0;
        });
      }

      setState(() {
        _titleOpacity = (_scrollController.offset / 120.0).clamp(0.0, 1.0);
      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.accessibility_outlined, color: Colors.red)),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Opacity(
                opacity: 1.0,
                child: _isAppBarCollapsed ? Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ) : null,
              ),
              background: Image.asset(
                "./images/lake.jpg",
                fit: BoxFit.cover,
              ),
            ),
            //iconTheme: IconThemeData(color: Colors.white),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    //创建子widget
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('grid item $index'),
                    );
                  },
                  childCount: 20,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4.0)),
          ),
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              }, childCount: 20),
              itemExtent: 50),
        ],
      ),
    );
  }
}
