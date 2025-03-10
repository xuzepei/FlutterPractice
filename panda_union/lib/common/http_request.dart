import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:panda_union/models/user.dart';

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
  var _isLoading = false;
  HttpRequestCallback? _callback;

  Future<void> get(String url, HttpRequestCallback callback) async {
    _callback = callback;

    if (_isLoading) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### get: $url");
    _isLoading = true;

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

      _isLoading = false;

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
      _isLoading = false;
      _callback?.call(null);
    }
  }

  Future<void> post(String url, Map<String, dynamic> params,
      HttpRequestCallback callback) async {
    _callback = callback;

    if (_isLoading) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### post: $url");
    debugPrint("#### params: $params");
    _isLoading = true;

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

      _isLoading = false;

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
      _isLoading = false;
      _callback?.call(null);
    }
  }

  Future<void> postWithBodyString(String url, String bodyString,
      HttpRequestCallback callback) async {
    _callback = callback;

    if (bodyString.isEmpty) {
      return;
    }

    if (_isLoading) {
      _callback?.call(null);
      return;
    }

    debugPrint("#### post: $url");
    debugPrint("#### bodyString: $bodyString");
    _isLoading = true;

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

      _isLoading = false;

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
      _isLoading = false;
      _callback?.call(null);
    }
  }
}
