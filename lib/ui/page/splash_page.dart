import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/route/route_manager.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  //BuildContext _context;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Image.asset(
        Utils.getImgPath("splash_bg"),
        width: double.infinity,
        fit: BoxFit.fill,
        height: double.infinity,
      ),
    );
  }

  void countDown() {
    var userModel = Provider.of<UserModel>(context, listen: false);
    Future.delayed(Duration(seconds: 3), (){
      //跳转并关闭当前页面
      if(userModel.hasUser) {
        Navigator.of(context).pushReplacementNamed(RouteName.main);
      } else {
        Navigator.of(context).pushReplacementNamed(RouteName.login);
      }
    });

  }
}