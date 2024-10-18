import 'package:flutter/material.dart';
import 'package:my_app/home/statemanagementtest.dart';
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
        // routes: {
        //   //"/":(context) => MyHomePage(title: "Flutter layout demo"),
        //   "/":(context) => BasicComponents(),
        //   "new_page":(context)=>NewRoute(),
        //   "new_page_with_args":(context)=>EchoRoute(),
        //   "tip_page_with_args":(context) {
        //     return TipRoute();
        //   }
        // },
        title: 'Flutter Demo',
        theme: ThemeData(
          //蓝色主题
          primarySwatch: Colors.blue,
        ),
        //home: CounterWidget(title: "Counter Widget")
        //home: StateLifecycleTest()
        //home: MyHomePage(title: "MyHomePage")
        //home: TapBoxesStatelessParent(title: "TapBoxesStatelessParent")
        home: TapBoxesStatefulParent(title: "TapBoxesStatefulParent")
        //home: HomePage(title: "Flutter layout demo"),
        //home: ListViewTest(title: "Mixed List"),
        //home: FloatAppBarPage(title: "Float App Bar"),
        //home: ParallaxRecipe(title: "Parallax Effect")
        );
  }
}

class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return CounterWidget(title: "Counter Widget");
  }

}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, required this.title, this.initValue = 0});

  final String title;
  final int initValue;

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void reset() {
    setState(() {
      _count=0;
    });
  }

  void increase() {
    setState(() {
      _count++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = widget.initValue;

    print("####: initState");
  }

  @override
  Widget build(BuildContext context) {
    print("####: _CounterWidgetState.build");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Material(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => {
                    print("####: clicked increase button."),
                    increase()
                  },


                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                  //   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  // ),
                  child: const Text("Increase")),
              const SizedBox(width: 16), //span
              Text(
                "Count: $_count",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.star,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
    // Material is a conceptual piece
    // of paper on which the UI appears.
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("####: _CounterWidgetState.didUpdateWidget");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("####: _CounterWidgetState.deactivate");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("####: _CounterWidgetState.dispose");
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    reset();
    print("####: _CounterWidgetState.reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("####: _CounterWidgetState.didChangeDependencies");
  }
}
