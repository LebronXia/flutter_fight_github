import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/index.dart';
import 'package:flutterfightgithub/common/localization/xstring.dart';
import 'package:flutterfightgithub/common/route/route_manager.dart';
import 'package:flutterfightgithub/data/net/HttpErrorEvent.dart';
import 'package:flutterfightgithub/data/net/code.dart';
import 'package:flutterfightgithub/ui/page/login_page.dart';
import 'package:flutterfightgithub/ui/page/splash_page.dart';
import 'package:flutterfightgithub/utils/storage_manager.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/login_model.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:provider/provider.dart';

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
  
  var userModel = UserModel();
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
        ChangeNotifierProvider.value(value: userModel),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //它在打开命名路由时可能会被调用
        onGenerateRoute: Router.generateRoute,
        home: SplashPage(),
      ),
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



