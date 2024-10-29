import 'package:flutter/material.dart';

class RowLayout extends StatelessWidget {
  const RowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 200,
      color: Colors.purple,
      padding: EdgeInsets.all(8),
      child: Container(
        color: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              color: Colors.red,
              child: Column(
                children: [
                  Text("Hello"),
                  Text("World!"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnLayout extends StatelessWidget {
  const ColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Container(
        width: 200,
        color: Colors.green,
        padding: EdgeInsets.all(8),
        child: Container(
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                color: Colors.red,
                child: Column(
                  children: [
                    Text("Hello"),
                    Text("World!"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComponentLinearLayout extends StatelessWidget {
  const ComponentLinearLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("LinearLayout"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. Row", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(" hello world "), Text(" I am Jack ")],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" hello world "),
                  Text(" I am Jack "),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(" hello world "),
                  Text(" I am Jack "),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Text(" hello world ", style: TextStyle(fontSize: 30.0),),
                  Text(" I am Jack "),
                ],
              ),
              SizedBox(height: 20,),
              Text("2. Column", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Expanded(//没有这个的话，黄色部分不会撑满，而会包裹内容的高度
                child: Container(
                  color: Colors.yellow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text("hi"),
                    Text("world"),
                    Text("!"),
                  ],),
                ),
              ),
            ],
          ),
        ));
  }
}
