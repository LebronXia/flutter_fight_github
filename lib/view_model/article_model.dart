import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/article.dart';
import 'package:flutterfightgithub/data/repository/home_repository.dart';
class ArticleModel extends ChangeNotifier{

  ///第一页页码
  static const int pageNumFirst = 1;
  ///当前页码
  int _currentPageNum = pageNumFirst;

  Future<List<Article>> getData() async{

    await HomeRepository.getArticleList(_currentPageNum).then((res){

      if(res == null && !res.result){

      } else {

      }
    });
  }
}