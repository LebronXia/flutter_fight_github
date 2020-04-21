import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/TrendingRepoModel.dart';
import 'package:flutterfightgithub/data/models/article.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/res/style.dart';
import 'package:flutterfightgithub/ui/widget/article_item.dart';
import 'package:flutterfightgithub/ui/widget/home_header_item.dart';
import 'package:flutterfightgithub/ui/widget/repo_item.dart';
import 'package:flutterfightgithub/ui/widget/trend_item.dart';
import 'package:flutterfightgithub/view_model/home_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {

  BuildContext _context;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  ///最新推荐
  Widget buildRecArticle(BuildContext context, List<Article> list){

    List<Widget> _children = list?.map((model){
      return new ArticleItem(model);
    })?.toList() ?? [];

    List<Widget> children = new List();

    children.add(HomeheaderItem(
      title: "最新推荐",
      titleColor: Colors.redAccent,
      leftIcon: Icons.whatshot,
    ));
    children.addAll(_children);

    return new Offstage(
      offstage: list == null || list.isEmpty,
      child: new Container(
        child: Column(
          //children在交叉轴方向的对齐方式，
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget buildGitTrending(BuildContext context, List<TrendingRepoModel> list){
    List<Widget> _children = list?.map((model){
      return new TrendItem(model);
    })?.toList() ?? [];

    List<Widget> children = new List();

    children.add(HomeheaderItem(
      title: "最新趋势",
      titleColor: Colors.blueAccent,
      leftIcon: MyIcons.trend_icon,
    ));

    children.addAll(_children);

    return new Offstage(
      offstage: list == null || list.isEmpty,
      child: new Container(
        child: Column(
          //children在交叉轴方向的对齐方式，
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );


  }

  Widget buildFloatingActionButton() {
    var homeModel = Provider.of<HomeModel>(widget._context, listen: false);
    return new FloatingActionButton(
        heroTag: "title_home'",
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          homeModel.getData();
        });
  }


  @override
  Widget build(BuildContext context) {

    return new ProviderWidget(
      model: HomeModel(),
      onModelReady: (model) => model.getData(),
      builder: (BuildContext context, HomeModel model, Widget child) {
        widget._context = context;

        return new Scaffold(
          body: new Stack(
            children: <Widget>[

              new SmartRefresher(
                controller: model.refreshController,
                header: WaterDropHeader(),
                footer: ClassicFooter(),
                enablePullUp: false,  //允许下拉刷新
                enablePullDown: true,  //允许上拉加载
                onRefresh: model.getData,
                child: new ListView(
                  children: <Widget>[
                    buildRecArticle(context, model.recArticlelist),
                    buildGitTrending(context, model.trendingList),
                  ],
                )
              )
            ],
          ),
          floatingActionButton: buildFloatingActionButton(),
        );
      }
    );
  }
  ///防止重复舒心
  @override
  bool get wantKeepAlive => true;
}




