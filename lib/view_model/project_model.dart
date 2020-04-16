import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/data/models/repo.dart';
import 'package:flutterfightgithub/data/repository/home_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectModel extends ChangeNotifier{

  ///第一页页码
  static const int pageNumFirst = 1;
  static const int pageSize = 20;

  ///当前页码
  int _currentPageNum = pageNumFirst;

  /// 页面数据
  List<Repo> _list = [];

  List<Repo> get list => _list;

  ///控制器
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  // 加载框是否可见
  bool _isLoading;

  bool get isLoading => _isLoading;

  ///刷新
  Future<List<Repo>> refresh() async{

    _isLoading = true;

    try{
      _currentPageNum = pageNumFirst;

      await HomeRepository.getRepos(_currentPageNum).then((res){
        if(res == null || !res.result){
          _list.clear();
          _refreshController.refreshCompleted();
        } else {
          _list.clear();
          _list.addAll(res.data);
          _refreshController.refreshCompleted();

          //小于分页数量，禁止加载更多
          if(res.data.length < pageSize){
            _refreshController.loadNoData();
          } else {
            _refreshController.loadComplete();
          }
          _isLoading = false;
          notifyListeners();
          return res.data;
        }
      });
    } catch(e,s){
      _refreshController.refreshFailed();
      return null;
    }
  }

  ///上拉加载更多
  Future<List<Repo>> loadMore() async {

    try{
      var data = await HomeRepository.getRepos(++_currentPageNum).then((res){
        if(res == null || !res.result){
          _currentPageNum--;
          _refreshController.loadNoData();
        } else {
          _list.addAll(res.data);
          if (res.data.length < pageSize) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
          notifyListeners();
        }
      });
    } catch(e, s){
      _currentPageNum--;
      refreshController.loadFailed();
      return null;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

}