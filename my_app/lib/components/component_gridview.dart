import 'package:flutter/material.dart';

class GridViewDemo extends StatefulWidget {
  GridViewDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GridViewDemoState();
  }
}

class GridViewDemoState extends State<GridViewDemo> {

  List<IconData> _icons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestIcons();
  }

  void requestIcons() {
    Future.delayed(Duration(milliseconds: 300)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text("GridView默认沾满整个空间，不能直接放入Column里显示，需要SizedBox来包裹限制高度", textAlign: TextAlign.center,),
          SizedBox(
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 100),
              children: [
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast)
              ],
            ),
          ),
          SizedBox(
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
            width: double.infinity,
            height: 2,
          ),
          SizedBox(
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100, childAspectRatio: 2.0),
              children: [
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast)
              ],
            ),
          ),
          SizedBox(
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
            width: double.infinity,
            height: 2,
          ),
          Text("动态添加子项的GridView"),
          SizedBox(
            height: 200,
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3.0), itemBuilder: (context, index) {
              return Icon(_icons[index]);
            }, itemCount: _icons.length,),
          ),
        ],
      ),
    );
  }
}
