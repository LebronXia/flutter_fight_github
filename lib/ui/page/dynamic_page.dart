import 'package:flutter/material.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/ui/widget/dynamic_item.dart';
import 'package:flutterfightgithub/view_model/dynamic_model.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:flutterfightgithub/widget/view_sate_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 主页动态tab页
class DynamicPage extends StatefulWidget {
  @override
  _DynamicPageState createState() => new _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage>
    with AutomaticKeepAliveClientMixin{

  UserModel _userModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<UserModel>(context, listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return new ProviderWidget(
        model: DynamicModel(),
        onModelReady: (model) => model.initData(_userModel.user.login),
        builder: (BuildContext context, DynamicModel model, Widget child) {
          return new Stack(
            children: <Widget>[
              new SmartRefresher(
                controller: model.refreshController,
                header: WaterDropHeader(),
                footer: ClassicFooter(),
                onRefresh: () async{
                  model.refresh(_userModel.user.login);
                },
                onLoading: () async{
                  model.loadMore(_userModel.user.login);
                },
                child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder:(context, index){
                return DynamicItem(model.list[index]);
              }
                ),
              ),
              new StatusViews(
                model.viewStatus,
                onTap: (){model.refresh(_userModel.user.login);},
              ),
            ],
          );

        },

    );
  }

  @override
  bool get wantKeepAlive => true;

}