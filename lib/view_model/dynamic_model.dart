import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/data/models/event.dart';
import 'package:flutterfightgithub/data/repository/home_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DynamicModel extends ChangeNotifier{

  ///第一页页码
  static const int pageNumFirst = 1;
  static const int pageSize = 20;
  ///当前页码
  int _currentPageNum = pageNumFirst;

  /// 页面数据
  List<Event> _list = [];

  List<Event> get list => _list;

  ///页面控制器
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  // 加载框是否可见
  bool _isLoading;

  bool get isLoading => _isLoading;

  ///界面状态
  int _viewStatus;

  int get viewStatus => _viewStatus;

  /// 第一次进入页面loading skeleton
  initData(username) async {
    await refresh(username);
  }

  Future<List<Event>> refresh(userName) async{

    //_isLoading = true;

    _viewStatus = MyLoadStatus.loading;
    notifyListeners();

    try{
      _currentPageNum = pageNumFirst;
      await HomeRepository.getDynamic(userName, _currentPageNum).then((res){

        if(res == null || !res.result){
          _list.clear();
          _refreshController.refreshCompleted();
          _viewStatus = MyLoadStatus.fail;
        } else {
          _list.clear();
          _list.addAll(res.data);
          _refreshController.refreshCompleted();

          if(_list.length == 0){
            _viewStatus = MyLoadStatus.empty;
            notifyListeners();
          } else {
            //小于分页数量，禁止加载更多
            if(res.data.length < pageSize){
              _refreshController.loadNoData();
            } else {
              _refreshController.loadComplete();
            }
            _viewStatus = MyLoadStatus.success;
          }
          notifyListeners();
          return res.data;
        }
      });
    } catch(e, s){

      _refreshController.refreshFailed();
      return null;
    }
  }

  ///上拉加载更多
  Future<List<Event>> loadMore(userName) async {

    try{
      await HomeRepository.getDynamic(userName, _currentPageNum).then((res){

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
}