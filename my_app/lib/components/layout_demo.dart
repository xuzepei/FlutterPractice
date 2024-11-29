import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            LayoutBuilder(builder: (_, constraints) {
              debugPrint("####: ${constraints.maxWidth}");
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      width: 206,
                      color: Colors.red,
                      child: Icon(
                        Icons.add,
                        size: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 206,
                      color: Colors.green,
                      child: Icon(
                        Icons.add,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

//Center默认尽量大(作为子组件时，充满屏幕)
//Container默认尽量小
//Row默认横向充满
//Column默认重向充满

  // Expanded 的主要作用：
  //Expanded 必须用于 Flex 布局（如 Row、Column、Flex），否则会报错。
  //Expanded 会强制其子组件填充可用空间。如果不希望子组件拉伸，请使用 Flexible 替代。
  // 弹性布局：Expanded 可以让子组件根据可用空间动态调整大小。
  // 比例分配空间：可以结合 flex 属性，按比例分配多个子组件的空间。
  // 避免溢出：在 Row 或 Column 中使用时，可以让子组件避免溢出，保持响应式布局。
}
