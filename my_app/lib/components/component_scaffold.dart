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
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scaffoldKey.currentState?.openDrawer();
    // });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("####: Context widget type: ${context.widget.runtimeType}");

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        //Scaffold 提供了一个默认的 Drawer 或 Navigator 功能，例如打开侧边栏。当你在 AppBar 的 leading 中直接使用一个按钮时，它默认会使用父级上下文，而这个上下文可能没有访问到 Scaffold 的状态。因此，无法正常触发 Scaffold 提供的功能，比如打开抽屉。
        //Builder 提供了一个新的上下文，该上下文能够正确访问 Scaffold 的状态，从而使 Scaffold.of(context) 能够正常工作。
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                debugPrint("####: clicked drawer button");
                //_scaffoldKey.currentState?.openDrawer();
                debugPrint(
                    "####: Builder context type: ${context.widget.runtimeType}");
                debugPrint(
                    "####: Builder context element type: ${context.runtimeType}");
                Scaffold.of(context)
                    .openDrawer(); //这种方法需要将 onPressed 放在一个能够访问 BuildContext 的地方（比如 Builder 小部件或 StatelessWidget 中）
              },
              icon: Icon(Icons.menu));
        }),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("####: clicked add button");
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
          child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Go back"),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, foregroundColor: Colors.white),
        ),
      )),
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
    debugPrint("#### onItemTapped: $index");

    setState(() {
      _selectedTabIndex = index;
    });
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  var icons = [
    Icon(Icons.add, size: 30),
    Icon(Icons.settings, size: 30),
  ];

  var titles = [
    "Add account",
    "Manage accounts",
    "Image & Icon",
    "Switch & Checkbox",
    "TextField",
    "Form",
    "Indicator",
    "ConstrainedBox & SizeBox",
    "LinearLayout",
    "Flex",
    "Wrap",
    "Stack",
    "Align",
    "LayoutBuilder",
    "DecoratedBox",
    "Transform",
    "Container",
    "Clip",
    "FittedBox",
    "Scaffold",
    "Test"
  ];

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
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) {
                      debugPrint(
                          "####: ${constraints.minHeight}, ${constraints.maxHeight}");
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Image.asset(
                          "images/user.png",
                          width: 90,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                          color: Colors.transparent,
                          child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 90),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Nickname",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )))))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: icons[index],
                        title: Text(titles[index],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18)),
                        onTap: () {
                          debugPrint("#### onTapDrawerMenu index: $index");
                        },
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
