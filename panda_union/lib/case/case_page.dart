import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/case/case_card_cell.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/common/errors.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/indicators.dart';
import 'package:panda_union/common/url_config.dart';
import 'package:panda_union/models/case.dart';

class CasePage extends StatefulWidget {
  const CasePage({super.key});

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  final TextEditingController _searchController = TextEditingController();
  final String _searchQuery = "";
  final FocusNode _searchBarFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();
  final double _opacity = 1.0;
  final List<Case> _items = [];
  final Map<String, String> _downloadedImagePath = {};
  bool _isRequesting = false;
  bool _isLoadingMore = false;
  bool _showNoData = false;
  int _pageIndex = 1;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(_onScroll);
    _requestCase();

    _searchBarFocus.addListener(() {
      debugPrint("#### Search bar has focus: ${_searchBarFocus.hasFocus}");
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

  void _checkIfNoData() {
    if (_items.isEmpty) {
      setState(() {
        _showNoData = true;
      });
    } else {
      setState(() {
        _showNoData = false;
      });
    }
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
        _downloadedImagePath.clear();

        for (var data in dataList) {
          Case item = Case(dataMap: data);
          _items.add(item);
          _downloadedImagePath[item.id] = "";
        }

        _pageIndex = 1;
      });

      _checkIfNoData();
    }

    void onError(String? msg) {
      debugPrint("#### requestCase error: $msg");
      setState(() {
        _isRequesting = false;
      });

      _checkIfNoData();
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

        for (var data in dataList) {
          Case item = Case(dataMap: data);
          _items.add(item);
          _downloadedImagePath[item.id] = "";
        }

        if (dataList.isNotEmpty) {
          _pageIndex += 1;
        }
      });

      _checkIfNoData();
    }

    void onError(String? msg) {
      debugPrint("#### loadMore error: $msg");
      setState(() {
        _isLoadingMore = false;
      });

      _checkIfNoData();
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

    debugPrint("#### itemCell: ${_items[index].id}");

    return CaseCardCell(
      key: ValueKey(_items[index].id),
      data: _items[index],
      localCaseImagePath: _downloadedImagePath[_items[index].id] ?? "",
      callback: (savePath, token) {
        if (savePath != null && token != null) {
          if (token.containsKey("case_id")) {
            String caseId = token["case_id"];
            if (_downloadedImagePath[caseId] != savePath) {
              setState(() {
                _downloadedImagePath[caseId] = savePath;
              });
            }
          }
        }
      },
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
            const SizedBox(height: 4),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: CupertinoScrollbar(
                    controller: _scrollController,
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _items.length + 1,
                        itemBuilder: _itemCell),
                  )),
            )
          ],
        )),
      ),
      AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _isRequesting ? Indicator.buildSpinIndicator() : null),
      if (_showNoData) MyCustom.buildNoDataWidget("No case found")
    ]);
  }
}
