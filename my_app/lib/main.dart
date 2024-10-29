import 'package:flutter/material.dart';
import 'package:my_app/home/statemanagementtest.dart';
import 'home/home.dart';
import 'home/listview.dart';
import 'home/floatappbar.dart';
import 'home/parallaxrecipe.dart';
import 'home/myhomepage.dart';
import 'components/basic_components.dart';
import 'util/tool.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //路由生成钩子, 方便根据命名统一做处理：比如判断是否要求登录
  Route<dynamic> createRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        Widget willShowWidget;
        String routeName = settings.name ?? "/";
        if(routeName == "/") {
          willShowWidget = MyHomePage(title: "MyHomePage");
        } else if(routeName == "new_page") {
          willShowWidget = NewPage();
        } else if(routeName == "echo_route") {
          willShowWidget = EchoRoute();
        } else if(routeName == "tip_page") {
          willShowWidget = TipPage(text: ModalRoute.of(context)!.settings.arguments as String?);
        } else {
          willShowWidget = MyHomePage(title: "MyHomePage");
        }

        return willShowWidget;
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/", //名为"/"的路由作为应用的home(首页)
      routes: {
        "/": (context) => BasicComponents(),//MyHomePage(title: "MyHomePage"), //首页路由
        "new_page": (context) => NewPage(), //通过名字来打开路由
        "echo_route": (context) => EchoRoute(), //通过名字来打开路由并传递参数
        "tip_page": (context) => TipPage(text: ModalRoute.of(context)!.settings.arguments as String?), //widget本身带有参数需要传参的情况
      },
      //onGenerateRoute: createRoute, //路由生成钩子, onGenerateRoute只会对命名路由生效, 但是不能直接传递参数，需要widget本身带参数传递
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue, // Set the primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.orange, // Set the accent color
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue, // Set the AppBar color
        ),
      ),
      //home: CounterWidget(title: "Counter Widget")
      //home: StateLifecycleTest()
      //home: MyHomePage(title: "MyHomePage")
      //home: TapBoxesStatelessParent(title: "TapBoxesStatelessParent")
      //home: TapBoxesStatefulParent(title: "状态管理Demo")
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
      _count = 0;
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
                  onPressed: () =>
                      {print("####: clicked increase button."), increase()},
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
