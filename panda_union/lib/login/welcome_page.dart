import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:panda_union/common/button.dart';
import 'package:panda_union/common/dialog.dart';
import 'package:panda_union/common/errors.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/common/keys.dart';
import 'package:panda_union/models/user.dart';
import 'package:panda_union/providers/network_provider.dart';
import 'package:panda_union/util/color.dart';
import 'package:panda_union/util/route.dart';
import 'package:panda_union/util/tool.dart';
import 'package:panda_union/util/url_config.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var _isRequesting = false;
  late NetworkProvider _networkProvider;
  late VoidCallback _networkListener;
  bool? _lastNetworkStatus;

  final _regionList = [
    ("cn", "China Mainland (CN)"),
    ("eu", "Europe (EU)"),
    ("in", "India (IN)"),
    ("en", "Other (EN)"),
  ];

  String _regionDisplayName = "";

  String getDisplayName(String region) {
    for (var item in _regionList) {
      if (item.$1 == region) {
        return item.$2;
      }
    }

    return "Select a region";
  }

  Future<void> _getRegion() async {
    String region = await Tool.getRegion();
    String displayName = getDisplayName(region);

    setState(() {
      _regionDisplayName = displayName;
    });
  }

  Future<void> _saveRegion(String region) async {
    bool b = await Tool.setRegion(region);
    if (b) {
      String displayName = getDisplayName(region);
      setState(() {
        _regionDisplayName = displayName;
      });
    }
  }

  Future<int> _getAPIHost() async {
    void onSuccess() {
      debugPrint("#### getAPIHost success.");

      setState(() {
        _isRequesting = false; // 关闭加载动画
      });
    }

    void onError(String? msg) {
      debugPrint("#### getAPIHost error: $msg");

      setState(() {
        _isRequesting = false; // 关闭加载动画
      });
    }

    setState(() {
      _isRequesting = true; // 显示加载动画
    });

    String region = await Tool.getRegion();
    if (region.isEmpty) {
      setState(() {
        _isRequesting = false; // 关闭加载动画
      });
      return -2;
    }

    String errorMsg = Errors.default_error;

    try {
      User.instance.region = region;

      // _dio.options.baseUrl = UrlConfig.instance.getBaseUrl();
      // String urlString = "/common/services";

      String urlString = UrlConfig.instance.apiHostUrl();
      await HttpRequest().get(urlString, (data) {
        if (data != null) {
          if (data.containsKey("success")) {
            var success = data["success"];
            if (success is bool && success) {
              if (data.containsKey("data")) {
                var dataMap = data["data"];
                if (dataMap is Map<String, dynamic>) {
                  UrlConfig.instance.saveAPIHostByRegion(dataMap);
                  onSuccess();
                }
              }
            }
          }
        } else {
          onError(errorMsg);
        }
      });

      return 0;
    } catch (e) {
      debugPrint("#### getAPIHost error: $e");
    } finally {}

    onError(errorMsg);
    return -1;
  }

  Future<bool> _checkAPIHost() async {
    String region = await Tool.getRegion();
    if (region.isEmpty) {
      return false;
    }

    Map<String, dynamic>? apiHost =
        await Tool.getMap(Keys.getAPIHostKey(region));
    if (apiHost == null) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    _getRegion();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //监听网络状态变化
    Future.delayed(Duration.zero, () {
      _listenNetworkChanges();
    });
  }

  @override
  void dispose() {
    _networkProvider.removeListener(_networkListener);

    super.dispose();
  }

  void _listenNetworkChanges() {
    _networkProvider = Provider.of<NetworkProvider>(context, listen: false);
    _networkListener = () {
      if (!mounted) return; // 避免 State 被卸载后仍然调用 setState 或 showToast

      bool currentStatus = _networkProvider.hasAvailableNetwork();

      if (currentStatus == false) {
        showNetworkStatusToast(currentStatus);
      }

      _lastNetworkStatus = currentStatus;
    };

    _networkProvider.addListener(_networkListener);
  }

  void showNetworkStatusToast(bool hasAvailableNetwork) {
    if (!mounted) return; // 避免 State 被卸载后仍然访问 context

    showTopToast(context, hasAvailableNetwork ? "wifi" : "none",
        Icons.check_circle, Colors.red);
  }

  void _clickedGetStartedBtn() {
    _getAPIHost().then((value) {
      if (!mounted) return;

      if (value == 0) {
        _checkAPIHost().then((value) {
          if (!mounted) return;
          if (value) {
            Navigator.pushNamed(context, loginPageRouteName);
          } else {
            MyDialog.show(context, "Tip", Errors.default_error, "OK");
          }
        });
      } else {
        MyDialog.show(
            context,
            "Tip",
            value == -2
                ? "Please select a business operation region first."
                : Errors.default_error,
            "OK");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //设置AppBar透明，body内容延伸到AppBar后面，但是不能用SafeArea.

          // extendBodyBehindAppBar: true,
          // backgroundColor: Colors.white,
          // appBar: AppBar(
          //   title: null, //Text("Title"),
          //   systemOverlayStyle: SystemUiOverlayStyle.dark,
          //   elevation: 0,
          //   surfaceTintColor: Colors.transparent,
          //   backgroundColor: Colors.transparent,
          // ),
          body: SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 60),
                          const Text("Welcome to",
                              style: TextStyle(fontSize: 24)),
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
                          const Text(
                              "Please select a business operation region first.",
                              style: TextStyle(
                                  fontSize: 16, color: MyColors.systemGray)),
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
                              //mode: Mode.custom, //自定义模式，不会显示下拉箭头
                              items: (f, cs) => _regionList,
                              compareFn: (item1, item2) {
                                // debugPrint("#### ${item1.$1}");
                                // debugPrint("#### ${item2.$1}");
                                return item1.$1 == item2.$1;
                              },
                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                onDismissed: () {
                                  debugPrint("#### onDismissed");
                                },
                                onItemsLoaded: (value) {
                                  debugPrint("#### onItemsLoaded");
                                },
                                menuProps: MenuProps(
                                    align: MenuAlign.bottomCenter,
                                    margin: EdgeInsets.only(top: 10)),
                                fit: FlexFit.loose,
                                itemBuilder:
                                    (context, item, isDisabled, isSelected) =>
                                        Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 10, top: 15, bottom: 15),
                                  child: Text(item.$2,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17)),
                                ),
                              ),
                              onChanged: (selectedItem) {
                                Future.delayed(Duration(milliseconds: 300), () {
                                  _saveRegion(selectedItem?.$1 ?? "").then((_) {
                                    _getAPIHost();
                                  });
                                });
                              },
                              enabled: !_isRequesting,
                              dropdownBuilder: (ctx, selectedItem) {
                                return SizedBox(
                                  height: 56,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 12, right: 8),
                                        child: Image.asset(
                                          "images/globe.png",
                                          width: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(_regionDisplayName,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          const SizedBox(height: 120),

                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 56,
                                  child: MyButton.build(
                                      onPressed: _clickedGetStartedBtn,
                                      text: "Get Started"),
                                ),
                              ),
                            ],
                          ),
                          //Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                            'Copyright © 2025 Freqty Inc. All rights reserved.',
                            style: TextStyle(
                                fontSize: 13, color: MyColors.systemGray))),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isRequesting)
          GestureDetector(
            onTap: () {
              debugPrint("#### block tap");
            },
            child: Container(
              color: Colors.black.withAlpha(0), // 半透明背景
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
      ],
    );
  }
}
