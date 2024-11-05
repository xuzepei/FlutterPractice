import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ClipDemo extends StatelessWidget {
  ClipDemo({super.key, required this.title});

  final String title;
  Widget avatar = Image.asset("images/lake.jpg", width: 100,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1. 不剪切", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            avatar,
            SizedBox(height: 20,),

            Text("2. 剪裁为椭圆形", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            ClipOval(child: avatar,),//如果avatar为正方形，则这个方法将剪切为圆形
            SizedBox(height: 20,),

            Text("3. 剪裁为圆角矩形", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            ClipRRect(child: avatar, borderRadius: BorderRadius.circular(10.0),),
            SizedBox(height: 20,),

            Text("4. 剪裁掉子组件布局空间之外的绘制内容", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                Text("你好世界", style: TextStyle(color: Colors.green),),
                SizedBox(width: 20,),
                Text("vs.", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),),
                SizedBox(width: 20,),
                ClipRect(child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),),
                Text("你好世界", style: TextStyle(color: Colors.green),)
              ],
            ),
            SizedBox(height: 20,),
            Text("5. 自定义裁剪", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            ClipRect(child: avatar, clipper: MyClipper()),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}


class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    debugPrint("####: size: $size");

    //从图片中心开始，剪切右下1/4部分
    return Rect.fromLTWH(size.width/2, size.height/2, size.width/2, size.height/2);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }

}