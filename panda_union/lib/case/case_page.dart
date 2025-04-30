import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/case/case_card_cell.dart';
import 'package:panda_union/case/case_filter_option.dart';
import 'package:panda_union/case/case_list_cell.dart';
import 'package:panda_union/common/custom.dart';
import 'package:panda_union/common/errors.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/common/color.dart';
import 'package:panda_union/common/indicators.dart';
import 'package:panda_union/common/keys.dart';
import 'package:panda_union/common/route.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/common/url_config.dart';
import 'package:panda_union/models/case.dart';

class CasePage extends StatefulWidget {
  const CasePage({super.key});

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  final FocusNode _searchBarFocus = FocusNode();

  final ScrollController _scrollController = ScrollController();
  final double _opacity = 1.0;
  final List<Case> _items = [];
  final Map<String, String> _downloadedImagePath = {};
  bool _isRequesting = false;
  bool _isLoadingMore = false;
  bool _showNoData = false;
  int _pageIndex = 1;
  bool _isCardCell = true;
  bool _hasFilter = false;

  final Map<String, List<String>> _caseFilter = {
    'types': [],
    'caseStatus': [],
  };
  bool? _isSend;

  final List<Map<String, String>> typeOptions = [
    {"name": "Orthodontics", "value": "1"},
    {"name": "Implant", "value": "2"},
    {"name": "Restoration", "value": "3"},
  ];
  List<String> selectedTypeOptions = [];

  final List<Map<String, String>> statusOptions = [
    {"name": "Received", "value": "1"},
    {"name": "Processing", "value": "2"},
    {"name": "Shipped", "value": "3"},
    {"name": "Completed", "value": "4"},
  ];
  List<String> selectedStatusOptions = [];

  final List<Map<String, String>> sourceOptions = [
    {"name": "As sender", "value": "1"},
    {"name": "As receiver", "value": "2"},
  ];
  List<String> selectedSourceOptions = [];

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(_onScroll);

    _searchBarFocus.addListener(() {
      debugPrint("#### Search bar has focus: ${_searchBarFocus.hasFocus}");
    });

    _loadCaseFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBarFocus.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _loadCaseFilters() async {
    String? selectedTypeValues = await Tool.getString(Keys.case_filter_type);
    String? selectedStatusValues =
        await Tool.getString(Keys.case_filter_status);
    String? selectedSourceValues =
        await Tool.getString(Keys.case_filter_source);

    bool tempHasFilter = false;
    if (selectedTypeValues != null && selectedTypeValues.isNotEmpty) {
      selectedTypeOptions = selectedTypeValues.split(",");
      tempHasFilter = true;
    }

    if (selectedStatusValues != null && selectedStatusValues.isNotEmpty) {
      selectedStatusOptions = selectedStatusValues.split(",");
      tempHasFilter = true;
    }

    if (selectedSourceValues != null && selectedSourceValues.isNotEmpty) {
      selectedSourceOptions = selectedSourceValues.split(",");
      tempHasFilter = true;
    }

    setState(() {
      _hasFilter = tempHasFilter;
    });

    _caseFilter['types'] = selectedTypeOptions;
    _caseFilter['caseStatus'] = selectedStatusOptions;

    _requestCase();
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
        onChanged: (query) {},
        onSubmitted: (query) {
          debugPrint("#### Search submitted: $query");
          setState(() {
            _searchQuery = query;
          });

          _requestCase();
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

      // Scroll to the top
      _scrollController.jumpTo(0);

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

      Map<String, dynamic> params = {
        "pageIndex": 1,
        "pageSize": 20,
        "keyword": _searchQuery,
        "sorter": {"time": "descend"},
        "filter": _caseFilter,
        "name": "",
        "receiveName": "",
        "sendName": ""
      };

      if (_isSend != null) {
        params["isSend"] = _isSend;
      }

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

      Map<String, dynamic> params = {
        "pageIndex": _pageIndex + 1,
        "pageSize": 20,
        "keyword": _searchQuery,
        "sorter": {"time": "descend"},
        "filter": _caseFilter,
        "name": "",
        "receiveName": "",
        "sendName": ""
      };

      if (_isSend != null) {
        params["isSend"] = _isSend;
      }

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

    var caseData = _items[index];

    if (_isCardCell) {
      return CaseCardCell(
        key: ValueKey(caseData.id),
        data: caseData,
        localCaseImagePath: _downloadedImagePath[caseData.id] ?? "",
        imageLoaderCallback: (savePath, token) {
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
        onTap: () {
          Navigator.pushNamed(context, caseDetailPageRouteName, arguments: {
            "case": caseData,
          });
        },
      );
    } else {
      return CaseListCell(
        key: ValueKey(caseData.id),
        data: caseData,
        onTap: () {
          Navigator.pushNamed(context, caseDetailPageRouteName, arguments: {
            "case": caseData,
          });
        },
      );
    }
  }

  void _tappedListStyleBtn() {
    setState(() {
      _isCardCell = !_isCardCell;
    });
  }

  void _onFilterDoneBtn() {
    debugPrint("#### Filter done");

    String selectedTypeValues = selectedTypeOptions.join(",");
    String selectedStatusValues = selectedStatusOptions.join(",");
    String selectedSourceValues = selectedSourceOptions.join(",");

    Tool.setValue(Keys.case_filter_type, selectedTypeValues);
    Tool.setValue(Keys.case_filter_status, selectedStatusValues);
    Tool.setValue(Keys.case_filter_source, selectedSourceValues);

    _caseFilter['types'] = selectedTypeOptions;
    _caseFilter['caseStatus'] = selectedStatusOptions;

    if (selectedSourceOptions.isEmpty) {
      _isSend = null;
    } else {
      String value = selectedSourceOptions[0];
      if (value == "1") {
        _isSend = true;
      } else if (value == "2") {
        _isSend = false;
      } else {
        _isSend = null;
      }
    }

    bool tempHasFilter = true;
    if (selectedTypeOptions.isEmpty &&
        selectedStatusOptions.isEmpty &&
        selectedSourceOptions.isEmpty) {
      tempHasFilter = false;
    }
    setState(() {
      _hasFilter = tempHasFilter;
    });

    _requestCase();

    Navigator.of(context).pop();
  }

  void _onFilterResetBtn() {
    debugPrint("#### Filter reset");

    setState(() {
      selectedTypeOptions.clear();
      selectedStatusOptions.clear();
      selectedSourceOptions.clear();
      _hasFilter = false;
    });

    String selectedTypeValues = selectedTypeOptions.join(",");
    String selectedStatusValues = selectedStatusOptions.join(",");
    String selectedSourceValues = selectedSourceOptions.join(",");

    Tool.setValue(Keys.case_filter_type, selectedTypeValues);
    Tool.setValue(Keys.case_filter_status, selectedStatusValues);
    Tool.setValue(Keys.case_filter_source, selectedSourceValues);

    _caseFilter['types'] = selectedTypeOptions;
    _caseFilter['caseStatus'] = selectedStatusOptions;
    _isSend = null;

    _requestCase();
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.all(8),
          children: [
            SafeArea(
              top: true,
              bottom: false,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('Case Filter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            CaseFilterOption(
              title: "Type",
              options: typeOptions,
              selectedOptions: selectedTypeOptions,
              onChanged: (List<String> selected) {
                selectedTypeOptions = selected;
              },
            ),
            SizedBox(height: 8),
            CaseFilterOption(
              title: "Progress",
              options: statusOptions,
              selectedOptions: selectedStatusOptions,
              onChanged: (List<String> selected) {
                selectedStatusOptions = selected;
              },
            ),
            SizedBox(height: 8),
            CaseFilterOption(
              title: "Source",
              options: sourceOptions,
              selectedOptions: selectedSourceOptions,
              onChanged: (List<String> selected) {
                selectedSourceOptions = selected;
              },
              isSingleSelect: true,
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 120,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(MyColors.systemGray6),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0)))), // 圆角大一点，就是胶囊
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        onPressed: () {
                          _onFilterResetBtn();
                        },
                      ),
                    ),
                    //const SizedBox(width: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 120,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor:
                                WidgetStatePropertyAll(MyColors.systemBlue),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0)))), // 圆角大一点，就是胶囊
                        child: Text(
                          "Done",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          _onFilterDoneBtn();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Opacity(
            opacity: _opacity,
            child: const Text("Case Management", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
          ),
          centerTitle: true,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: _tappedListStyleBtn,
                icon: Image.asset(
                  _isCardCell ? "images/list_cell.png" : "images/card_cell.png",
                  width: 28,
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      debugPrint("#### Filter button tapped");
                      //AppBar 里的 context 不能直接用 Scaffold.of(context)，
                      //需要用 Builder 包一层
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Image.asset(
                      "images/filter.png",
                      width: 24,
                      color: _hasFilter ? MyColors.systemBlue : Colors.black,
                    ));
              }),
            )
          ],
        ),
        endDrawer: _buildDrawer(),
        body: SafeArea(
            child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 4),
            Expanded(
              child: Stack(children: [
                RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: CupertinoScrollbar(
                      controller: _scrollController,
                      child: (_items.isEmpty && _showNoData)
                          ? MyCustom.buildNoDataWidget("No case found")
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: _items.length + 1,
                              itemBuilder: _itemCell),
                    )),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: (_isRequesting)
                        ? Indicator.buildSpinIndicator()
                        : null),
              ]),
            )
          ],
        )),
      ),
    ]);
  }
}
