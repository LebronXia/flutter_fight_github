import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/trenduser.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/trend_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///趋势-用户页面
class TrendUserPage extends StatefulWidget {
  @override
  _TrendUserPageState createState() => new _TrendUserPageState();
}

class _TrendUserPageState extends State<TrendUserPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
        model: TrendModel(),
        onModelReady: (model) => model.getTrendingUser("Dart", "daily"),
        builder: (BuildContext context, TrendModel model, Widget child){
            return Stack(
              children: <Widget>[
                new SmartRefresher(
                  controller: model.refreshController,
                  header: WaterDropHeader(),
                  footer: ClassicFooter(),
                  onRefresh: () async{
                    model.getTrendingUser("Dart", "daily");
                  },
                  enablePullUp: true,
                  child: ListView.builder(
                      itemCount: model.trendUserList.length,
                      itemBuilder: (context, index){
                        Trenduser repo = model.trendUserList[index];
                        return Material(
                          shape: BorderDirectional(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: .5,
                              )
                          ),
                          child:  InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Utils.gmAvatar(
                                  repo.avatar,
                                  width: 30.0,
                                ),
                                title: Text(
                                    repo.username + "(" + repo.name + ")"
                                ),
                                dense: true,
                              ),
                            ),
                            onTap: (){
                              Utils.showToast("点击~");
                            },
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
         },
        );
  }

  ///防止重复刷新
  @override
  bool get wantKeepAlive => true;
}