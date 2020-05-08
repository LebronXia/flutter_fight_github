import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/trendrepo.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/ui/widget/trend_repo_item.dart';
import 'package:flutterfightgithub/view_model/trend_model.dart';
import 'package:flutterfightgithub/widget/view_sate_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///趋势-项目页面
class TrendRepoPage extends StatefulWidget {
  @override
  _TrendRepoPageState createState() => new _TrendRepoPageState();
}

class _TrendRepoPageState extends State<TrendRepoPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return new ProviderWidget(
      model: TrendModel(),
      onModelReady: (model) => model.getTrendingRepos("Dart", "daily"),
      builder: (BuildContext context, TrendModel model, Widget child) {
        return new Stack(
          children: <Widget>[
            new SmartRefresher(
                controller: model.refreshController,
                header: WaterDropHeader(),
                footer: ClassicFooter(),
                //显示底部标题
                enablePullUp: true,
                onRefresh: () async{
                  model.getTrendingRepos("Dart", "daily");
                },
              child: ListView.builder(
                itemCount: model.trendingList.length,
                  itemBuilder: (context, index){
                    TrendingReposBean repo = model.trendingList[index];
                    return TrendRepoItem(repo);
                  }),

            ),
            new StatusViews(
              model.viewStatus,
              onTap: (){
                model.getTrendingRepos("Dart", "daily");
              },
            )
          ] ,
        );
      },
    );
  }

  ///防止重复刷新
  @override
  bool get wantKeepAlive => true;
}