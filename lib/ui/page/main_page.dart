import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutterfightgithub/ui/page/article_page.dart';
import 'package:flutterfightgithub/ui/page/dynamic_page.dart';
import 'package:flutterfightgithub/ui/page/home_page.dart';
import 'package:flutterfightgithub/ui/page/issue_page.dart';
import 'package:flutterfightgithub/ui/page/my_drawer.dart';
import 'package:flutterfightgithub/ui/page/project_page.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:provider/provider.dart';

final List<String> _allPage = ["主页", "项目" , "动态", "issues" ];

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context, listen: false);

    return new DefaultTabController(
      length: _allPage.length,
      child: new Scaffold(
        appBar: new MyAppBar(
          leading: ClipOval(
            child: userModel.hasUser ?
            Utils.gmAvatar(userModel.user.avatarUrl, width: 40)
                : Image.asset(
                    Utils.getImgPath('ali_connors'),
                    width: 40,
            ),
          ),
          centerTitle: true,
          title: new Tablayout(),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: (){
                  Utils.showToast("跳转搜索~~");
                }
            )
          ],
        ),
        body: new TabBarViewLayout(),
        drawer: MyDrawer(),
      ),
    );
  }
}

class TabBarViewLayout extends StatelessWidget{

  Widget buildTabView(BuildContext context, String page){
      switch(page){
        case "主页":
          return HomePage();
          break;
        case "项目":
          return ProjectPage();
          break;
        case "动态":
          return DynamicPage();
          break;
        case "issues":
          return IssuePage();
          break;
        default:
          return Container();
          break;
      }
  }

  @override
  Widget build(BuildContext context) {
      return new TabBarView(
          children: _allPage.map((e) =>
            buildTabView(context, e)).toList(),
      );
  }
}

class Tablayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new TabBar(
      isScrollable: true,
        labelPadding: EdgeInsets.all(12.0),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _allPage.map((e) =>
          new Tab(text: e)).toList()
    );
  }
}


