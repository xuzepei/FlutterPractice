import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/models/user.dart';
import 'package:path_provider/path_provider.dart';

typedef HttpRequestCallback = void Function(Map<String, dynamic>? data);

class HttpRequest {
  // 私有的构造函数
  HttpRequest._privateConstructor();

  // 静态实例
  static HttpRequest? _instance;
  static HttpRequest get instance {
    _instance ??= HttpRequest._privateConstructor();
    return _instance!;
  }

  HttpRequest();

  final Dio _dio = Dio();
  var _isRequesting = false;
  HttpRequestCallback? _callback;

  Future<void> get(String url, HttpRequestCallback callback) async {
    _callback = callback;

    if (_isRequesting) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### get: $url");
    _isRequesting = true;

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": User.instance.authorization(),
          },
        ),
      );

      _isRequesting = false;

      debugPrint("#### response.data: ${response.data}");
      // debugPrint(
      //     "#### response.data.runtimeType: ${response.data?.runtimeType}");

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> data = response.data;
          _callback?.call(data);
          return;
        }
      }

      _callback?.call(null);
    } catch (e) {
      debugPrint("#### get error: $e");
      _isRequesting = false;
      _callback?.call(null);
    }
  }

  Future<void> post(String url, Map<String, dynamic> params,
      HttpRequestCallback callback) async {
    _callback = callback;

    if (_isRequesting) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### post: $url");
    debugPrint("#### params: $params");
    _isRequesting = true;

    try {
      Response response = await _dio.post(
        url,
        data: params,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": User.instance.authorization(),
          },
        ),
      );

      _isRequesting = false;

      debugPrint("#### response.data: ${response.data}");
      // debugPrint(
      //     "#### response.data.runtimeType: ${response.data?.runtimeType}");

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> data = response.data;
          _callback?.call(data);
          return;
        }
      }

      _callback?.call(null);
    } catch (e) {
    debugPrint("#### post error: $e");
      _isRequesting = false;
      _callback?.call(null);
    }
  }

  Future<void> postWithBodyString(
      String url, String bodyString, HttpRequestCallback callback) async {
    _callback = callback;

    if (bodyString.isEmpty) {
      return;
    }

    if (_isRequesting) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### post: $url");
    debugPrint("#### bodyString: $bodyString");
    _isRequesting = true;

    try {
      Response response = await _dio.post(
        url,
        data: bodyString,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
            "Authorization": User.instance.authorization(),
          },
        ),
      );

      _isRequesting = false;

      debugPrint("#### response.data: ${response.data}");
      // debugPrint(
      //     "#### response.data.runtimeType: ${response.data?.runtimeType}");

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> data = response.data;
          _callback?.call(data);
          return;
        }
      }

      _callback?.call(null);
    } catch (e) {
      debugPrint("#### post error: $e");
      _isRequesting = false;
      _callback?.call(null);
    }
  }

  Future<void> download(String url, HttpRequestCallback callback) async {
    _callback = callback;

    if (_isRequesting) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### download: $url");
    _isRequesting = true;

    try {
      String savePath = await Tool.getImageLocalPath(url);
      if(isEmptyOrNull(savePath)) {
        _callback?.call(null);
        return;
      }

      Response response = await _dio.download(
        url,
        savePath,
        options: Options(
          headers: {
            "Authorization": User.instance.authorization(),
          },
        ),
      );

      _isRequesting = false;

      debugPrint("#### response.data: ${response.data}");
      debugPrint(
          "#### response.data.runtimeType: ${response.data.runtimeType}");
      debugPrint("#### response.statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, dynamic> data = {};
        data["image_path"] = savePath;
        _callback?.call(data);
        return;
      }

      _callback?.call(null);
    } catch (e) {
      debugPrint("#### get error: $e");
      _isRequesting = false;
      _callback?.call(null);
    }
  }
}
