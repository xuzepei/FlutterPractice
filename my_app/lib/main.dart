import 'package:flutter/material.dart';
import 'home/home.dart';
import 'home/listview.dart';
import 'home/floatappbar.dart';
import 'home/parallaxrecipe.dart';
import 'home/myhomepage.dart';
import 'components/basic_components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //"/":(context) => MyHomePage(title: "Flutter layout demo"),
        "/":(context) => BasicComponents(), 
        "new_page":(context)=>NewRoute(),
        "new_page_with_args":(context)=>EchoRoute(),
        "tip_page_with_args":(context) {
          return TipRoute();
        }
      },
        //title: 'Flutter Demo',
        //home: MyHomePage(title: "Flutter layout demo")
        //home: HomePage(title: "Flutter layout demo"),
        //home: ListViewTest(title: "Mixed List"),
        //home: FloatAppBarPage(title: "Float App Bar"),
        //home: ParallaxRecipe(title: "Parallax Effect")
        );
  }
}



class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});

  final String title;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => {
                    setState(() {
                      // This call to setState tells the Flutter framework that something has
                      // changed in this State, which causes it to rerun the build method below
                      // so that the display can reflect the updated values. If we changed
                      // _counter without calling setState(), then the build method would not be
                      // called again, and so nothing would appear to happen.
                      count++;
                    }),
                    print("click click")
                  },
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
              //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              // ),
              child: const Text("Increase")),
          const SizedBox(width: 16),
          Text("Count: $count"),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    setState(() {
      count = 0;
    });
  }
}


