import 'package:panda_union/util/tool.dart';

class User {
  // 私有的构造函数
  User._privateConstructor();

  // 静态实例
  static User? _instance;

  static User get instance {
    if (_instance == null) {
      return User._privateConstructor();
    }
    return _instance!;
  }

  Future<bool> isLoggedIn() async {
    String? value = await Tool.getString(access_token_key);
    if (!isEmptyOrNull(value)) {
      return true;
    }
    return false;
  }
}
