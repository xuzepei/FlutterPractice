import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _controller;

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: WebViewWidget(controller: _controller));
  }
}
