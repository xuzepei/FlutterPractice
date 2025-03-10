import 'package:flutter/material.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/common/errors.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/url_config.dart';

class CasePage extends StatefulWidget {
  const CasePage({super.key});

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;
  //List<> _items = List.generate(20, (index) => 'Item $index');

  bool _isRequesting = false;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      debugPrint('#### Scroll offset: ${_scrollController.offset}');

      // setState(() {
      //   // Adjust opacity based on scroll position
      //   _opacity = (_scrollController.offset / 50).clamp(0.0, 1.0);
      // });
    });

    _requestCase();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: const TextStyle(color: MyColors.systemGray),
          filled: true,
          fillColor: MyColors.systemGray6,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
        ),
        onChanged: (query) {
          // setState(() {
          //   _searchQuery = query;
          // });
        },
      ),
    );
  }

  Future<void> _requestCase() async {
    if (_isRequesting || _isLoadingMore) {
      return;
    }

    void onSuccess() {
      debugPrint("#### requestCase success.");
      setState(() {
        _isRequesting = false;
      });
    }

    void onError(String? msg) {
      debugPrint("#### requestCase error: $msg");
      setState(() {
        _isRequesting = false;
      });
    }

    setState(() {
      _isRequesting = true; // 显示加载动画
    });

    String errorMsg = Errors.default_error;

    try {
      String urlString = await UrlConfig.instance.caseListUrl();

      Map<String, dynamic> filter = {
        "types": [],
        "caseStatus": [],
      };

      Map<String, dynamic> params = {
        "pageIndex": 1,
        "pageSize": 20,
        "keyword": _searchQuery,
        "name": "",
        "receiveName": "",
        "sendName": ""
      };

      await HttpRequest().post(urlString, params, (data) {
        if (data != null) {
          if (data.containsKey("success")) {
            var success = data["success"];
            if (success is bool && success) {
              if (data.containsKey("data")) {
                var dataList = data["records"];
                if (dataList is List) {
                  onSuccess();
                }
              }
            }
          }
        } else {
          onError(errorMsg);
        }
      });

      return;
    } catch (e) {
      debugPrint("#### requestCase error: $e");
    } finally {}

    onError(errorMsg);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: MyCustom.buildAppBar(
            "Case Management", _opacity, context, null, true),
        body: SafeArea(
            child: Column(
          children: [
            _buildSearchBar(),
          ],
        )),
      ),
      if (_isRequesting)
        GestureDetector(
          onTap: () {
            debugPrint("#### block tap");
          },
          child: Container(
            color: Colors.black.withAlpha(100), // 半透明背景
            child: Center(
              //child: SpinKitCircle(color: Colors.blue, size: 50.0),
              child: CircularProgressIndicator(
                // You can set color, stroke width, etc.
                valueColor: AlwaysStoppedAnimation<Color>(
                    MyColors.primaryColor), // Color of the progress bar
                strokeWidth: 3.0, // Thickness of the line
              ),
            ),
          ),
        ),
    ]);
  }
}
