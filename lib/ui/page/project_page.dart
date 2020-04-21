import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/repo.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/ui/widget/repo_item.dart';
import 'package:flutterfightgithub/view_model/project_model.dart';
import 'package:flutterfightgithub/widget/view_sate_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///自己的项目仓库
class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => new _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ProjectModel>(
      model: ProjectModel(),
      onModelReady: (model) => model.refresh(),
      builder: (BuildContext context, ProjectModel model, Widget child) {

          return Stack(
            children: <Widget>[
              new SmartRefresher(
                controller: model.refreshController,
                header: WaterDropHeader(),
                footer: ClassicFooter(),
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                //???
                enablePullUp: true,
                child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index){
                Repo repo = model.list[index];
                return  RepoItem(repo);
                }
              ),
              ),
              new StatusViews(
                model.viewStatus,
                onTap: (){
                  debugPrint("ProgressViews onRefresh......");
                  model.refresh();
                },
              ),
            ],
          );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}