import 'package:flutter/cupertino.dart';

class LocaleModel extends ChangeNotifier{

  String mLocale;

  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (mLocale == null) return null;
    var t = mLocale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Localle的字符串表示
  String get local => mLocale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != mLocale) {
      mLocale = locale;
      notifyListeners();
    }
  }

}