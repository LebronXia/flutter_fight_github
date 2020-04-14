import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/index.dart';
import 'package:flutterfightgithub/common/route/route_manager.dart';
import 'package:flutterfightgithub/data/net/HttpErrorEvent.dart';
import 'package:flutterfightgithub/data/net/code.dart';
import 'package:flutterfightgithub/ui/page/splash_page.dart';
import 'package:flutterfightgithub/utils/storage_manager.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/locale_model.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/i10n/localization_intl.dart';
import 'common/i10n/xstring.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  StreamSubscription _httpErrorSubscription;

  @override
  void initState() {
    super.initState();
    _httpErrorSubscription = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<UserModel, LocaleModel>(
        builder: (BuildContext context, userModel, localeModel, Widget child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateTitle: (context){
              // 此时context在Localizations的子树中
              return GmLocalizations.of(context).title;
            },
            //它在打开命名路由时可能会被调用
            onGenerateRoute: Router.generateRoute,
            home: SplashPage(),
            locale: localeModel.getLocale(),
            //我们只支持美国英语和中文简体
            supportedLocales: [
              const Locale('en', 'US'), // 美国英语
              const Locale('zh', 'CN'), // 中文简体
              //其它Locales
            ],
            localizationsDelegates: [
              RefreshLocalizations.delegate, //下拉刷新
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GmLocalizationsDelegate()
            ],
            localeResolutionCallback:
                (Locale _locale, Iterable<Locale> supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();
              } else {
                Locale locale;
                //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
                //则默认使用美国英语
                if (supportedLocales.contains(_locale)) {
                  locale= _locale;
                } else {
                  locale= Locale('en', 'US');
                }
                return locale;
              }
            },
          );
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    _httpErrorSubscription.cancel();
    _httpErrorSubscription = null;
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Utils.showToast(
             XString.network_error);
        break;
      case 401:
        Utils.showToast(
          XString.network_error_401);
        break;
      case 403:
        Utils.showToast(
            XString.network_error_403);
        break;
      case 404:
        Utils.showToast(
            XString.network_error_404);
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
        Utils.showToast(
            XString.network_error_timeout);
        break;
      default:
        Utils.showToast(
            XString.network_error_unknown +
                " " +
                message);
        break;
    }
  }

}



