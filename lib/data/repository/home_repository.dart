import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/data/api/apis.dart';
import 'package:flutterfightgithub/data/models/TrendingRepoModel.dart';
import 'package:flutterfightgithub/data/models/article.dart';
import 'package:flutterfightgithub/data/models/common-data.dart';
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

  ///Trending 趋势
  static Future<DataResult> getTrending({selectTime = 'daily', languageType, page = 0}) async{
    var res = await httpRequest.request(GithubApi.trendingApi(selectTime, languageType), null, {'api-token': Config.API_TOKEN}, null);

    if (res != null && res.result){
      List<TrendingRepoModel> list = new List();
      res.data.forEach((item){
        list.add(TrendingRepoModel.fromJson(item));
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

  ///最新项目
  static Future<DataResult> getRecArticle(page) async{
    var res = await httpRequest.get(GithubApi.getPath(path: GithubApi.NEW_ARTICLE, page: page), {"cid": 402});

    if (res != null && res.result){
      List<Article> list = new List();
      ComResult comResult = ComResult.fromJson(res.data);
      comResult.data.datas.forEach((item){
        list.add(Article.fromJson(item));
      });
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      return DataResult(list, true);
    } else {
      return DataResult(res.data.data, false);
    }
  }

  ///推荐项目列表
  static Future<DataResult> getRecRepos(page) async{
    var res = await httpRequest.get(GithubApi.getPath(path: GithubApi.PROJECT_LIST, page: page), null);

    if (res != null && res.result){
      List<Article> list = new List();
      res.data.forEach((item){
        list.add(Article.fromJson(item));
      });
      return DataResult(list, true);
    } else {
      return DataResult(res.data, false);
    }
  }

  ///查看某个公众号历史数据
  static Future<DataResult> getRecWxArticle(page) async{
    var res = await httpRequest.get(GithubApi.getPath(path: GithubApi.PROJECT_LIST, page: page), null);

    if (res != null && res.result){
      List<Article> list = new List();
      res.data.forEach((item){
        list.add(Article.fromJson(item));
      });
      return DataResult(list, true);
    } else {
      return DataResult(res.data, false);
    }
  }

}