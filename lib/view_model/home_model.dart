import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/data/models/TrendingRepoModel.dart';
import 'package:flutterfightgithub/data/models/article.dart';
import 'package:flutterfightgithub/data/repository/home_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeModel extends ChangeNotifier{

  List<Article> _recArticlelist = [];
  List<TrendingRepoModel> _trendingList = [];

  List<Article> get recArticlelist => _recArticlelist;
  List<TrendingRepoModel> get trendingList => _trendingList;

  RefreshController _controller = new RefreshController();
  RefreshController get refreshController => _controller;

  void getData(){
    getRecArticle();
    getTrending("Dart");
  }

  Future<List<Article>> getRecArticle() async{
    await HomeRepository.getRecArticle(0).then((res){
        if(res != null && res.result){
          _recArticlelist.clear();
          _recArticlelist.addAll(res.data);
          notifyListeners();
        }
    });
  }

  Future<List<TrendingRepoModel>> getTrending(selectType) async{
    await HomeRepository.getTrending(languageType: selectType).then((res){
      if(res != null || res.result){
        _trendingList.clear();
        _trendingList.addAll(res.data);

        _controller.refreshCompleted();
        _controller.loadNoData();
        notifyListeners();
      }
    });
  }

}