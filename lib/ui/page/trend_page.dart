import 'package:flutter/material.dart';
import 'package:flutterfightgithub/ui/page/main_page.dart';
import 'package:flutterfightgithub/ui/page/trend_repo_page.dart';

class TrendPage extends StatelessWidget {
  final List<String> _allPage = ["项目", "用户"];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: _allPage.length,
        child:  new Scaffold(
           appBar: new AppBar(
             title: new Tablayout(_allPage),
             centerTitle: true,
          ),
          body: new TabBarViewLayout(_allPage),
        ),
    );

  }
}

class TabBarViewLayout extends StatelessWidget{

  TabBarViewLayout(this.list) : super();
  final List<String> list;

  Widget buildTabView(BuildContext context, String page){
    switch(page){
      case "项目":
        return TrendRepoPage();
        break;
      case "用户":
        return TrendRepoPage();
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new TabBarView(
      children: list.map((e) =>
          buildTabView(context, e)).toList(),
    );
  }
}


class Tablayout extends StatelessWidget{

  Tablayout(this.list) : super();
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return new TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.all(12.0),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: list.map((e) =>
          new Tab(text: e)).toList()
    );
  }
}