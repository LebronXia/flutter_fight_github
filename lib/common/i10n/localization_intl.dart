//国际化  Localizations 组件一般位于widget树中其它业务组件的顶部，它的作用是定义区域Locale以及设置子树依赖的本地化资源
import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/i10n/messages_all.dart';
import 'package:intl/intl.dart';

class GmLocalizations{

  static Future<GmLocalizations> load(Locale locale){
    final String name =
    locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    
    final String localeName = Intl.canonicalizedLocale(name);

    //执行命令后生成
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new GmLocalizations();
    });
  }

  //为了使用方便，我们定义一个静态方法
  static GmLocalizations of(BuildContext context){
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  //需要切换中英文的字段
  String get title {
    return Intl.message(
      'Github客户端',
      name: "title",
      desc: 'Title for Demo application',
    );
  }

  String get home => Intl.message('主页', name: 'home');

  String get language => Intl.message('语言', name: 'language');

  String get login => Intl.message('登录', name: 'login');

  String get auto => Intl.message('自动', name: 'auto');

  String get setting => Intl.message('设置', name: 'setting');

  String get theme => Intl.message('主题', name: 'theme');
  String get trend => Intl.message("趋势", name: 'trend');

  String get userName => Intl.message('用户名', name: 'userName');
  String get userNameRequired => Intl.message("账号不能为空!" , name: 'userNameRequired');
  String get password => Intl.message('密码', name: 'password');
  String get passwordRequired => Intl.message('密码不能为空!', name: 'passwordRequired');
  String get userNameOrPasswordWrong=>Intl.message('用户名或密码不正确!', name: 'userNameOrPasswordWrong');
  String get logout => Intl.message('注销', name: 'logout');
  String get logoutTip => Intl.message('确定要退出当前账号吗??', name: 'logoutTip');
  String get yes => Intl.message('确定', name: 'yes');
  String get noDescription => Intl.message('没有描述', name: 'noDescription');
  String get cancel => Intl.message('取消', name: 'cancel');
}

//Locale代理类
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations>{
  const GmLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalizations> load(Locale locale) {
    return GmLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(LocalizationsDelegate<GmLocalizations> old) => false;

}