import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/data/api/apis.dart';
import 'package:flutterfightgithub/data/models/TrendingRepoModel.dart';
import 'package:flutterfightgithub/data/models/trendrepo.dart';
import 'package:flutterfightgithub/data/models/trenduser.dart';
import 'package:flutterfightgithub/data/net/HttpRequest.dart';
import 'package:flutterfightgithub/data/net/data_result.dart';

class TrendRepository{

  ///获取趋势项目
  static Future<DataResult> getTrendingRepos({languageType, selectTime = 'daily'}) async{
    var res = await httpRequest.get(GithubApi.getTrendingRepos(languageType, selectTime), null);

    if (res != null && res.result){
      List<TrendingReposBean> list = new List();
      res.data.forEach((item){
        list.add(TrendingReposBean.fromJson(item));
      });
      return DataResult(list, true);
    } else {
      return DataResult(res.data, false);
    }
  }

  ///获取趋势用户
  static Future<DataResult> getTrendingUser({languageType, selectTime = 'daily'}) async{

    var res = await httpRequest.get(GithubApi.getTrendingUser(languageType, selectTime), null);
    if (res != null && res.result){
      List<Trenduser> list = new List();
      res.data.forEach((item){
        list.add(Trenduser.fromJson(item));
      });
      return DataResult(list, true);
    } else {
      return DataResult(res.data, false);
    }
  }
}