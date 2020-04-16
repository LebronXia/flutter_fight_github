import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/repository/home_repository.dart';

class DynamicModel extends ChangeNotifier{

  ///第一页页码
  static const int pageNumFirst = 1;
  static const int pageSize = 20;
  ///当前页码
  int _currentPageNum = pageNumFirst;

  Future<List> refresh(userName) async{

    try{

      _currentPageNum = pageNumFirst;
      var data = await HomeRepository.getDynamic(userName, _currentPageNum);
    } catch(e, s){

    }
  }
}