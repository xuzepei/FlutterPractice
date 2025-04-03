import 'dart:io';

import 'package:flutter/material.dart';
import 'package:panda_union/common/http_request.dart';
import 'package:panda_union/common/tool.dart';
import 'package:panda_union/common/url_config.dart';

typedef ImageLoaderCallback = void Function(String? savePath);

class ImageLoader {
  // 私有的构造函数
  ImageLoader._privateConstructor();

  // 静态实例
  static final ImageLoader _instance = ImageLoader._privateConstructor();
  factory ImageLoader() => _instance;
  static ImageLoader get instance {
    return _instance;
  }

  List<String> requestUrls = [];
  ImageLoaderCallback? _callback;

  Future<void> loadCaseImageById(
      String caseId, ImageLoaderCallback callback) async {
    _callback = callback;

    void onSuccess(String savePath) {
      debugPrint("#### download success: $savePath");

      if (_callback != null) {
        _callback!(savePath);
      }
    }

    void onError(String? msg) {
      debugPrint("#### download error: $msg");
    }

    String urlString =
        await UrlConfig.instance.caseFileHostUrl() + "/$caseId/data.png";

    // 先检查本地是否有缓存
    String savePath = await Tool.getImageLocalPath(urlString);
    if (!isEmptyOrNull(savePath)) {
      File file = File(savePath);
      if (file.existsSync()) {
        onSuccess(savePath);
        return;
      }
    }

    // 如果没有缓存，则下载
    await HttpRequest().download(urlString, (data) {
      if (data != null) {
        if (data.containsKey("image_path")) {
          var savePath = data["image_path"];
          onSuccess(savePath);
          return;
        }
      }

      onError("");
    });
  }
}
