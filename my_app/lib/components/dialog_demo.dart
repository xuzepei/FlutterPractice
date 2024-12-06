import 'package:flutter/material.dart';

class DialogDemo extends StatelessWidget {
  DialogDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Future<bool?> showDeleteConfirmDialog() {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text("Tip"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0), // 圆角
              ),
              content: Text("Are you sure to delete this file?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel")),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          });
    }

    Future<void> selectLanguage(BuildContext context) async {
      int? i = await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: Text("Please select language"),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop(1);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Text("Simplified Chinese"),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop(2);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Text("American English"),
                  ),
                ),
              ],
            );
          });

      if (i == 1) {
        debugPrint("####: Selected Simplified Chinese.");
      } else if (i == 2) {
        debugPrint("####: Selected American English.");
      } else {
        debugPrint("####: Selected nothing.");
      }
    }

    Future showListDialog(BuildContext context) async {
      int? index = await showDialog(
          context: context,
          builder: (context) {
            var child = Column(
              children: [
                ListTile(
                  title: Text("Please select"),
                ),
                //必须要有Expanded，否则无法计算listview高度，导致报错
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text("$index"),
                          onTap: () => Navigator.of(context).pop(index));
                    },
                    itemCount: 30,
                  ),
                )
              ],
            );

            //使用AlertDialog会报错, 因为AlertDialog使用来IntrinsicWidth,
            //会根据子组件的内容来设置大小，遇到listview这种lazy加载的，就会有问题。
            //return AlertDialog(content: child);

            //可以使用Dialog
            //return Dialog(child: child,);

            //还可以不使用任何Dialog,比如：
            return UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 280),
                child: Material(
                  child: child,
                  type: MaterialType.card,
                ),
              ),
            );
          });

      if (index != null) {
        debugPrint("####: clicked item $index in list.");
      }
    }

    Widget _buildDialogTransition(BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child);
    }

    Future<bool?> showCustomDialog(BuildContext context) async {
      var pageChild = AlertDialog(
        title: Text("Tip"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0), // 圆角
        ),
        content: Text("Are you sure to delete this file?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      );

      bool? b = await showGeneralDialog(
          context: context,
          barrierColor: Colors.red.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 200),
          transitionBuilder: _buildDialogTransition,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return SafeArea(child: Builder(builder: (context) {
              return pageChild;
            }));
          });

      return b;
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  //必须使用bool?, 才能获取到b==null的情况，比如点击外部关闭或者按返回关闭
                  bool? b = await showDeleteConfirmDialog();
                  if (b == true) {
                    debugPrint("####: clicked delete button.");
                  } else if (b == false) {
                    debugPrint("####: clicked cancel button.");
                  } else {
                    debugPrint("####: clicked outside area.");
                  }
                },
                child: Text("Show AlertDialog")),
            ElevatedButton(
                onPressed: () {
                  selectLanguage(context);
                },
                child: Text("Show SimpleDialog")),
            ElevatedButton(
                onPressed: () {
                  showListDialog(context);
                },
                child: Text("Show a list in Dialog")),
            ElevatedButton(
                onPressed: () async {
                  bool? b = await showCustomDialog(context);
                  if (b != null) {
                    debugPrint("####: showCustomDialog, result: $b");
                  }
                },
                child: Text("Show general dialog")),
          ],
        ),
      ),
    );
  }
}
