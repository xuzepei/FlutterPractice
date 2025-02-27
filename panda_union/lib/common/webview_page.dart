import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  String? _title;
  String? _url;

  void initController() {
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) {},
      onPageStarted: (url) {},
      onPageFinished: (url) {},
    ));
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve arguments passed from the previous screen
    final Map<String, String> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>? ??
            {};

    debugPrint(
        "#### didChangeDependencies, args: ${ModalRoute.of(context)?.settings.arguments}");

    // Ensure the title and url are set if available
    setState(() {
      _title = args['title'] ?? 'Default Title';
      _url = args['url'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Map<String, String> arguments =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // _title = arguments["title"] ?? "";
    // _url = arguments["url"] ?? "";

    return Scaffold(
        appBar: AppBar(
          title: Text(_title ?? ""),
        ),
        body: WebViewWidget(controller: _controller));
  }
}
