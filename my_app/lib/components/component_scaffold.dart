import 'package:flutter/material.dart';

class ScaffoldDemo extends StatefulWidget {
  ScaffoldDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return ScaffoldDemoState();
  }
}

class ScaffoldDemoState extends State<ScaffoldDemo> {
  int _selectedTabIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // 在 Widget 构建完成后调用 openDrawer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.openDrawer();
    });

  }

  @override
  Widget build(BuildContext context) {

    debugPrint("####: Context widget type: ${context.widget.runtimeType}");

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: () {
              debugPrint("####: clicked drawer button");
              //_scaffoldKey.currentState?.openDrawer();
              debugPrint("####: Builder context type: ${context.widget.runtimeType}");
              debugPrint("####: Builder context element type: ${context.runtimeType}");
              Scaffold.of(context).openDrawer(); //这种方法需要将 onPressed 放在一个能够访问 BuildContext 的地方（比如 Builder 小部件或 StatelessWidget 中）
            }, icon: Icon(Icons.menu));
          }
        ),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("####: clicked add button");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        child: Text("Hello world!"),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "School"),
        ],
        currentIndex: _selectedTabIndex,
        fixedColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [LayoutBuilder(builder: (_, constraints) {
                  debugPrint("####: ${constraints.minHeight}, ${constraints.maxHeight}");
                  return Container(alignment: Alignment.center, color:Colors.blue, child: Image.asset("images/user.png", width: 90,),);
                },), SizedBox(width: 15,), Expanded(child: Container(color:Colors.red,child: ConstrainedBox(constraints: BoxConstraints(minHeight: 90),child: Align(alignment: Alignment.centerLeft,child: Text("Nickname sfjslfjlsdjflsjfldjsldjsljlfjsklfjls131312313132132131231232131231312313", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)))))],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [Icon(Icons.add, size: 30),SizedBox(width: 15,),Text("Add account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [Icon(Icons.settings, size: 30,),SizedBox(width: 15,),Text("Manage accounts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
