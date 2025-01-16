class UrlConfig {
  // 私有的构造函数
  UrlConfig._privateConstructor();

  // 静态实例
  static UrlConfig? _instance;
  static UrlConfig get instance {
    if (_instance == null) {
      return UrlConfig._privateConstructor();
    }
    return _instance!;
  }

  final baseUrlList = [
    ("cn", "https://cn.freqtek.com"),
    ("eu", "https://eu.freqtek.com"),
    ("in", "https://in.freqtek.com"),
    ("en", "https://en.freqtek.com"),
  ];

  String region = "";
  String getBaseUrl(String? region) {
    for (var item in baseUrlList) {
      if (region == null) {
        break;
      } else {
        if (item.$1 == region) {
          return item.$2;
        }
      }
    }

    return baseUrlList[0].$2;
  }

  String getApiUrl(String region, String path) {
    return getBaseUrl(region) + path;
  }
}
