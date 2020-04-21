import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfightgithub/ui/page/home_page.dart';
import 'package:flutterfightgithub/ui/page/login_page.dart';
import 'package:flutterfightgithub/ui/page/main_page.dart';
import 'package:flutterfightgithub/ui/page/splash_page.dart';
import 'package:flutterfightgithub/ui/page/trend_page.dart';
import 'package:flutterfightgithub/widget/page_route_anim.dart';

class RouteName{
  static const String splash = 'splash';
  static const String main = 'main';
  static const String login = 'login';
  static const String trend = "trend";
}

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.main:
        return NoAnimRouteBuilder(MainPage());
      case RouteName.login:
        return CupertinoPageRoute(fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.trend:
        return CupertinoPageRoute(builder: (_) => TrendPage());
    }

  }
}