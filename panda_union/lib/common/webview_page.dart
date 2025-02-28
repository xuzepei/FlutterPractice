import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/util/tool.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  bool _isLoading = false;

  String? _title;
  String? _url;

  void initWebViewController() {
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) {},
      onPageStarted: (url) {
        setState(() {
          _isLoading = true;
        });
      },
      onPageFinished: (url) {
        setState(() {
          _isLoading = false;
        });
      },
      onWebResourceError: (error) {
        debugPrint("#### onWebResourceError: $error");
        setState(() {
          _isLoading = false;
        });
      },
      onHttpError: (error) {
        debugPrint("#### onHttpError: $error");
        setState(() {
          _isLoading = false;
        });
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    initWebViewController();
  }

  @override
  void dispose() {
    super.dispose();
  }

//One way to access route arguments correctly in State<WebViewPage> is to use the didChangeDependencies method,
//which is called when the widget's dependencies change, including when the route arguments are available.
//This method is called immediately after initState and before build.
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
      _title = args['title'] ?? '';
      _url = args['url'] ?? '';
    });

    if (!isEmptyOrNull(_url)) {
      _controller.loadRequest(Uri.parse(_url ?? ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustom.buildAppBar(
          _title ?? "",
          1.0,
          context,
          [
            IconButton(
                onPressed: () {
                  _controller.reload();
                },
                icon: Icon(
                  Icons.refresh,
                  size: 28,
                ))
          ],
        ),
        body: SafeArea(
            child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: WebViewWidget(controller: _controller),
          ),
          if (_isLoading) const Center(child: CupertinoActivityIndicator())
        ])));
  }
}
