import 'package:panda_union/util/tool.dart';

class User {
  // 私有的构造函数
  User._privateConstructor();

  // 静态实例（直接初始化）
  static final User _instance = User._privateConstructor();
  // 工厂构造函数返回单例
  factory User() => _instance;

  static User get instance {
    return _instance;
  }

  Future<bool> isLoggedIn() async {
    try {
      String? value = await Tool.getString(access_token_key);
      if (!isEmptyOrNull(value)) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }
}
