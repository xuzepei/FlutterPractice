import 'package:flutter/material.dart';

class DialogDemo2 extends StatefulWidget {
  DialogDemo2({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogDemo2State();
  }
}

class DialogDemo2State extends State<DialogDemo2> {
  bool isChecked = false;
  BuildContext? dialogContext = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  bool? b = await showStateDialog(context);
                  if (b == true) {
                    debugPrint("####: 确认删除文件！是否同时删除目录: $isChecked");
                  }
                },
                child: Text("显示包含状态的对话框")),
            ElevatedButton(
                onPressed: () async {
                  int? index = await showBottomSheet(context);
                  if (index != null) {
                    debugPrint("####: 选择了条目: $index");
                  }
                },
                child: Text("显示一个底部对话框")),
            ElevatedButton(
                onPressed: () async {
                  await showLoadingDialog(context);

                  Future.delayed(Duration(seconds: 6), () {
                    if(dialogContext != null) {
                      if(Navigator.canPop(dialogContext!)) {
                        Navigator.pop(dialogContext!);
                      }
                    }
                  });

                },
                child: Text("显示模态Loading对话框")),


          ],
        ),
      ),
    );
  }

  Future<bool?> showStateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          isChecked = false;

          //企图在父路由中调用setState来让子路由更新，这显然是不行的
          //需要使用StatefulBuilder包裹
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("提示"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("您确定要删除当前文件吗？"),
                  Row(
                    children: [
                      Text("同时删除目录？"),
                      Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });

                            debugPrint(
                                "#### checkbox state is changed as $isChecked");
                          })
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("取消")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      "删除",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            );
          });
        });
  }

  Future<int?> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
            itemCount: 30,
          );
        });
  }

  Future showLoadingDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {

          dialogContext = context;

          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    )),
              ],
            ),
          );
        });
  }
}
