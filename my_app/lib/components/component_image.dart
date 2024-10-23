import 'package:flutter/material.dart';
import '../util/iconfont.dart';



class ComponentImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image & Icon"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //3.3.1
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "3.3.1.1 Load image from local",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                      image: AssetImage(
                        'images/lake.jpg',
                      ),
                      width: 200,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "3.3.1.2 Load image from url",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                      image: NetworkImage("https://picsum.photos/300/200"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "3.3.1.3 show image with color",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                        image: AssetImage(
                          'images/lake.jpg',
                        ),
                        color: Colors.red,
                        colorBlendMode: BlendMode.color),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "3.3.2 Icon",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      Icon(Icons.accessible, color: Colors.green,),
                      Icon(Icons.error, color: Colors.red,),
                      Icon(Icons.fingerprint, color: Colors.blue, size: 100,),
                      Icon(IconFont.user, color: Colors.black, size: 30,),
                    ],mainAxisAlignment: MainAxisAlignment.center,)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
