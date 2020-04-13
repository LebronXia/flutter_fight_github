import 'package:flutter/material.dart';
import 'package:flutterfightgithub/ui/page/home_page.dart';
import 'package:flutterfightgithub/ui/page/login_page.dart';
import 'package:flutterfightgithub/ui/page/mian_page.dart';
import 'package:flutterfightgithub/ui/page/splash_page.dart';
import 'package:flutterfightgithub/widget/page_route_anim.dart';

class RouteName{
  static const String splash = 'splash';
  static const String main = 'main';
  static const String login = 'login';
}

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.login:
        return NoAnimRouteBuilder(LoginPage());
      case RouteName.main:
        return NoAnimRouteBuilder(MainPage());
    }

  }
}