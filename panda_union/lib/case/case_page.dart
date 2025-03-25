import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/common/animated_tick_indicator.dart';
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

class _CasePageState extends State<CasePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final String _searchQuery = "";
  final FocusNode _searchBarFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();
  final double _opacity = 1.0;
  final List _items = [];
  bool _isRequesting = false;
  bool _isLoadingMore = false;
  bool _showCheckmark = false;
  int _pageIndex = 1;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(_onScroll);
    _requestCase();

    _searchBarFocus.addListener(() {
      debugPrint("#### Search bar has focus：${_searchBarFocus.hasFocus}");
    });


  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBarFocus.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextField(
        focusNode: _searchBarFocus,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: const TextStyle(color: MyColors.systemGray),
          filled: true,
          fillColor: MyColors.systemGray6,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
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

    void onSuccess(List dataList) {
      debugPrint("#### requestCase success.");
      setState(() {
        _isRequesting = false;
        _items.clear();
        _items.addAll(dataList);
        _pageIndex = 1;
        _showCheckmark = true;
        
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _showCheckmark = false;
        });
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
        "sorter": {"time": "descend"},
        "filter": filter,
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
                var dataMap = data["data"];
                if (dataMap is Map<String, dynamic>) {
                  var dataList = dataMap["records"];
                  if (dataList is List) {
                    onSuccess(dataList);
                  }
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

  Future<void> _loadMore() async {
    if (_isRequesting || _isLoadingMore) {
      return;
    }

    void onSuccess(List dataList) {
      debugPrint("#### loadMore success.");
      setState(() {
        _isLoadingMore = false;
        _items.addAll(dataList);
        if (dataList.isNotEmpty) {
          _pageIndex += 1;
        }
      });
    }

    void onError(String? msg) {
      debugPrint("#### loadMore error: $msg");
      setState(() {
        _isLoadingMore = false;
      });
    }

    setState(() {
      _isLoadingMore = true; // 显示加载动画
    });

    String errorMsg = Errors.default_error;

    try {
      String urlString = await UrlConfig.instance.caseListUrl();

      Map<String, dynamic> filter = {
        "types": [],
        "caseStatus": [],
      };

      Map<String, dynamic> params = {
        "pageIndex": _pageIndex + 1,
        "pageSize": 20,
        "keyword": _searchQuery,
        "sorter": {"time": "descend"},
        "filter": filter,
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
                var dataMap = data["data"];
                if (dataMap is Map<String, dynamic>) {
                  var dataList = dataMap["records"];
                  if (dataList is List) {
                    onSuccess(dataList);
                  }
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
      debugPrint("#### loadMore error: $e");
    } finally {}

    onError(errorMsg);
  }

  Future<void> _onRefresh() async {
    debugPrint("#### refresh case list.");

    _requestCase();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // At the bottom of the list, load more

      debugPrint("#### loadmore list.");

      _loadMore();
    }
  }

  Widget? _loadMoreCell(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CupertinoActivityIndicator()),
    );
  }

  Widget? _itemCell(BuildContext context, int index) {
    if (index == _items.length && _items.isNotEmpty) {
      // Loading indicator at the bottom
      return _loadMoreCell(context);
    }

    if (_items.isEmpty || index >= _items.length) {
      return null;
    }

    return ListTile(
      title: Text(_items[index]["patientName"] ?? ""),
    );
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
            Expanded(
              child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _items.length + 1,
                      itemBuilder: _itemCell)),
            )
          ],
        )),
      ),
      AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _isRequesting
              ? GestureDetector(
                  onTap: () {
                    debugPrint("#### block tap");
                  },
                  child: Container(
                    color: Colors.black.withAlpha(0), // 半透明背景
                    child: Center(
                      //child: SpinKitCircle(color: Colors.blue, size: 50.0),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: MyColors.systemGray6.withAlpha(255), // 背景颜色
                          borderRadius: BorderRadius.circular(10), // 圆角半径
                        ),
                        child: CupertinoActivityIndicator(
                          radius: 16,
                        ),
                      ),
                    ),
                  ),
                )
              : null),
      if (_showCheckmark)
        AnimatedTickIndicator(text: "Success",)
    ]);
  }
}


