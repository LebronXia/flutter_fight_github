import 'package:flutterfightgithub/data/api/apis.dart';
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
//        for(int i = 0; i < res.data.length; i++){
//          list.add(Repo.fromJson(res.data[i]));
//        }
       // list = res.data.map((e) => Repo.fromJson(e)).toList();
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

    }
  }
}