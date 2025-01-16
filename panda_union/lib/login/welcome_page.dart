import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:panda_union/main.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';
import 'package:panda_union/util/url_config.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Dio _dio = Dio();
  var _isLoading = false;

  final _regionList = [
    ("cn", "China Mainland (CN)"),
    ("eu", "Europe (EU)"),
    ("in", "India (IN)"),
    ("en", "Other (EN)"),
  ];

  String _currentRegion = "";
  String _regionDisplayName = "";

  String getDisplayName(String region) {
    for (var item in _regionList) {
      if (item.$1 == region) {
        return item.$2;
      }
    }

    return "Select Operational Region";
  }

  Future<void> _getRegion() async {
    String region = await Tool.getRegion();
    String displayName = getDisplayName(region);

    setState(() {
      _currentRegion = region;
      _regionDisplayName = displayName;
    });
  }

  Future<void> _saveRegion(String region) async {
    bool b = await Tool.setRegion(region);
    if (b) {
      String displayName = getDisplayName(region);
      setState(() {
        _currentRegion = region;
        _regionDisplayName = displayName;
      });
    }
  }

  Future<void> _getAPIHost() async {

    setState(() {
      _isLoading = true; // 显示加载动画
    });

    String region = await Tool.getRegion();
    if (isEmptyOrNull(region)) {
      setState(() {
        _isLoading = false; // 关闭加载动画
      });
      return;
    }

    try {
      UrlConfig.instance.region = region;
      _dio.options.baseUrl = UrlConfig.instance.getBaseUrl(region);
      String urlString = "/common/services";
      Response response = await _dio.get(urlString);
      debugPrint("#### getAPIHost: ${response.data}");
    } catch (e) {
      debugPrint("#### getAPIHost error: $e");
    } finally {
      setState(() {
        _isLoading = false; // 关闭加载动画
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getRegion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Stack(children: [
        Container(
          padding:
              const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Welcome to", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 8),
              const Text(appName,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryColor)),
              const SizedBox(height: 8),
              const Text(
                  "A communication tool app designed specifically for Labs, clinics, and dentists.",
                  style: TextStyle(fontSize: 17)),
              const SizedBox(height: 26),
              const Text("Please select a business operation region first.",
                  style: TextStyle(fontSize: 16, color: MyColors.systemGray)),
              const SizedBox(height: 16),

              //下拉菜单
              DropdownSearch<(String, String)>(
                  clickProps: ClickProps(
                    borderRadius: BorderRadius.circular(10),
                    onTapUp: (TapUpDetails details) {
                      debugPrint("#### onTapUp");
                    },
                    onFocusChange: (value) {
                      debugPrint("#### onFocusChange: $value");
                    },
                  ),
                  mode: Mode.custom,
                  items: (f, cs) => _regionList,
                  compareFn: (item1, item2) => item1.$1 == item2.$1,
                  popupProps: PopupProps.menu(
                    menuProps: MenuProps(
                        align: MenuAlign.bottomCenter,
                        margin: EdgeInsets.only(top: 10)),
                    fit: FlexFit.loose,
                    itemBuilder: (context, item, isDisabled, isSelected) =>
                        Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 10, top: 15, bottom: 15),
                      child: Text(item.$2,
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                    ),
                  ),
                  onChanged: (selectedItem) {
                    _saveRegion(selectedItem?.$1 ?? "").then((_) {
                      _getAPIHost();
                    });
                  },
                  dropdownBuilder: (ctx, selectedItem) {
                    return Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: OutlinedButton(
                              onPressed: null,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1.0,
                                    color: Colors.black), // 设置边框宽度和颜色
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10.0), // 设置圆角
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "images/globe.png",
                                    width: 24,
                                  ),
                                  Text(_regionDisplayName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      )),
                                  Image.asset("images/arrow_down.png",
                                      width: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

              const SizedBox(height: 60),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(MyColors.primaryColor),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6.0)))),
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        if (_isLoading)
          IgnorePointer(
            ignoring: true, // 禁止与底层组件的交互
            child: Container(
              color: Colors.black.withOpacity(0.5), // 半透明背景
              child: Center(
                child: SpinKitCircle(color: Colors.blue, size: 50.0),
              ),
            ),
          ),
      ]),
    );
  }
}
