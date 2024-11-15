import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  ListViewDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListViewDemoState();
  }
}

class ListViewDemoState extends State<ListViewDemo> {
  static String loadMoreTag = "##loadMore##";
  var list = <String>[loadMoreTag];
  var _isLoading = false;
  var _needToIndicator = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () {
              return requestData(false);
            },
            child: ListView.separated(
                itemBuilder: (context, index) {
                  if (list[index] == loadMoreTag) {
                    if (list.length == 1) {
                      return null;
                    }

                    if (list.length - 1 < 100) {
                      //requestData();
                      return Container(
                        color: Colors.yellow,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text("No More Data",
                                textScaler: TextScaler.linear(1.5))),
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title:
                            Text(list[index], textScaler: TextScaler.linear(1.5)),
                        onTap: () {
                          debugPrint("#### onTapListItemIndex: $index");
                        },
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Divider(height: 0, color: Colors.grey[200]),
                  );
                },
                itemCount: list.length),
          ),

          if(_isLoading)
            Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: _needToIndicator ? CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 2.0,
              ) : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> requestData(bool needToShowIndicator) async{
    setState(() {
      _needToIndicator = needToShowIndicator;
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        list.insertAll(
            list.length - 1,
            generateWordPairs().take(20).map((e) {
              return e.asPascalCase;
            }).toList());
        _isLoading = false;
        _needToIndicator = true;
      });
    });
  }
}
