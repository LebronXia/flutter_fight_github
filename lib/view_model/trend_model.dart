import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/data/models/TrendingRepoModel.dart';
import 'package:flutterfightgithub/data/models/trendrepo.dart';
import 'package:flutterfightgithub/data/models/trenduser.dart';
import 'package:flutterfightgithub/data/repository/trend_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrendModel extends ChangeNotifier{

  List<TrendingReposBean> _trendingList = [];

  List<TrendingReposBean> get trendingList => _trendingList;

  List<Trenduser> _trendUserList = [];

  List<Trenduser> get trendUserList => _trendUserList;

  ///控制器
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  int _viewStatus;

  int get viewStatus => _viewStatus;

  Future<List<TrendingReposBean>> getTrendingRepos(languageType, selectTime) async{
    _viewStatus = MyLoadStatus.loading;
    notifyListeners();

      await TrendRepository.getTrendingRepos(languageType: languageType, selectTime: selectTime).then((res){
        if(res == null || !res.result){
          _trendingList.clear();
          _refreshController.refreshCompleted();
          _viewStatus = MyLoadStatus.fail;
        } else {
          _trendingList.clear();
          _trendingList.addAll(res.data);
          _refreshController.refreshCompleted();
          _refreshController.loadNoData();
          _viewStatus = MyLoadStatus.success;
        }

        notifyListeners();
      });
  }

  Future<List<Trenduser>> getTrendingUser(languageType, selectTime) async{
    await TrendRepository.getTrendingUser(languageType: languageType, selectTime: selectTime).then((res){

      _viewStatus = MyLoadStatus.loading;
      notifyListeners();

      if(res == null || !res.result){
        _trendUserList.clear();
        _refreshController.refreshCompleted();
        _viewStatus = MyLoadStatus.fail;
      } else {
        _trendUserList.clear();
        _trendUserList.addAll(res.data);
        _refreshController.refreshCompleted();
        _refreshController.loadNoData();
        _viewStatus = MyLoadStatus.success;
      }
    });

    notifyListeners();
  }
}