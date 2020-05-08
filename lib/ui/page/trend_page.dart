import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/ui/page/main_page.dart';
import 'package:flutterfightgithub/ui/page/trend_repo_page.dart';
import 'package:flutterfightgithub/ui/page/trend_user_page.dart';

class TrendPage extends StatelessWidget {
  final List<String> _allPage = ["项目", "用户"];

  String _language, _since;

  Widget _buildLanguageMenu(){
    return PopupMenuItem(
      value: "language",
        child: ListTile(
          title: Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.text_rotate_vertical, color: XColors.gray_66, size: 22.0,),
                SizedBox(width: 5.0,),
                Text("Language ${TextUtil.isEmpty(_language) ? "all" : _language}", style: TextStyle(fontSize: 14.0, color: XColors.gray_66),)
              ],
            ),
          ),

        )
    );
  }

  Widget _buildDateRangeMenu(){
    return PopupMenuItem(
        value: "daterange",
        child: ListTile(
          title: Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Icon(Icons.text_rotate_vertical, color: XColors.gray_66, size: 22.0,),
                SizedBox(width: 5.0,),
                Text("Date Range $_since", style: TextStyle(fontSize: 14.0, color: XColors.gray_66),)
              ],
            ),
          ),

        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: _allPage.length,
        child:  new Scaffold(
           appBar: new MyAppBar(
             title: new Tablayout(_allPage),
             centerTitle: true,
             actions: <Widget>[
               PopupMenuButton(
                 padding: const EdgeInsets.all(0.0),
                   itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                     _buildLanguageMenu(),
                    _buildDateRangeMenu(),
                   ],
               )
             ],
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
        return TrendUserPage();
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
        indicatorColor: Colors.white,
        tabs: list.map((e) =>
          new Tab(text: e)).toList()
    );
  }
}