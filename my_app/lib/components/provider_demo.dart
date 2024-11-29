import 'package:flutter/material.dart';
import 'package:my_app/util/colorex.dart';
import 'package:provider/provider.dart';

class ProviderDemo extends StatefulWidget {
  ProviderDemo({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProviderDemoState();
  }
}

class ProviderDemoState extends State<ProviderDemo> {

  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//不能在组件的 initState 中直接调用 Provider.of，因为 initState 执行时组件树还未完全初始化。这种情况下可以使用 Provider 的 listen: false 或 Future.microtask。
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cart = Provider.of<Cart>(context,listen: false);
      cart.clearItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: ColorEx.withHexString("#ffff00"),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("${cart.items.length} items in cart."),

              Consumer<Cart>(builder: (BuildContext context, Cart value, Widget? child) {
                return Text("Use Consumer widget: ${value.items.length} items in cart.");
              },),
              ElevatedButton(onPressed: () {
              debugPrint("####: clicked add item button.");
              count++;
              cart.addItem("item$count");

              debugPrint("####: cart.items: ${cart.items.toString()}");

            }, child: Text("Add", style: TextStyle(fontWeight: FontWeight.bold),))],
          ),
        ),
      ),
    );
  }
}

class Cart extends ChangeNotifier {
  List<String> items = [];

  void addItem(String item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    items.remove(item);
    notifyListeners();
  }

  void clearItems() {
    items.clear();
    notifyListeners();
  }
}
