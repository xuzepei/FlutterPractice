import 'package:flutter/material.dart';

class ComponentImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image & Icon"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                      width: 100,
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
                        colorBlendMode: BlendMode.difference),
                    SizedBox(
                      height: 30,
                    ),

                    Row(children: [
                      Icon(Icons.accessible, color: Colors.green,),
                      Icon(Icons.error, color: Colors.orange,),
                      Icon(Icons.fingerprint, color: Colors.blue, size: 100,),
                    ],mainAxisAlignment: MainAxisAlignment.center,)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
