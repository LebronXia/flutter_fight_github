import 'package:flutter/material.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/view_model/article_model.dart';

/// Flutter文章
class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => new _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      model: ArticleModel(),
      onModelReady: (model) => model.getData(),
      builder: (BuildContext context, ArticleModel model, Widget child) {

        return new Center(
          child: Text(
            "Flutter"
          ),
        );
      },
    );
  }
}