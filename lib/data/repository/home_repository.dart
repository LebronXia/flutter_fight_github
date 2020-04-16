import 'package:flutterfightgithub/data/api/apis.dart';
import 'package:flutterfightgithub/data/models/article.dart';
import 'package:flutterfightgithub/data/models/event.dart';
import 'package:flutterfightgithub/data/models/repo.dart';
import 'package:flutterfightgithub/data/net/HttpRequest.dart';
import 'package:flutterfightgithub/data/net/data_result.dart';

class HomeRepository{

  //项目列表
  static Future<DataResult> getRepos(page) async{
      await Future.delayed(Duration(seconds: 1));
      var res = await httpRequest.get(GithubApi.getRepos() + GithubApi.getPageParams("?", page), null);
      if (res != null && res.result){
        List<Repo> list = new List();
        res.data.forEach((item){
          list.add(Repo.fromJson(item));
        });
        return DataResult(list, true);
      } else {
         return DataResult(res.data, false);
      }
  }

  //动态列表
  static Future<DataResult> getDynamic(userName, page) async{
    await Future.delayed(Duration(seconds: 1));
    var res = await httpRequest.get(GithubApi.getEventReceived(userName) + GithubApi.getPageParams("?", page), null);
    if (res != null && res.result){
      List<Event> list = new List();
      res.data.forEach((item){
        list.add(Event.fromJson(item));
      });
      return DataResult(list, true);
    } else {
      return DataResult(res.data, false);
    }
  }

  ///文章列表
  static Future<DataResult> getArticleList(int page) async{

    var res = await httpRequest.get(GithubApi.getPath(path:GithubApi.ARTICLE_LIST, page: page), null);
    if(res != null && res.result){

    }
  }
}