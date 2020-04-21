
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/article.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/res/dimens.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/widget/widget.dart';

class ArticleItem extends StatelessWidget {
  ArticleItem(this.article) : super(key: ValueKey(article.id));
  final Article article;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new BorderDirectional(
              bottom: new BorderSide(color: Colors.black12, width: 1.0)
          )
      ),
      child: new FlatButton(
          onPressed: null,
          child: new Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: new Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //即从顶向低排列
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    new Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                article.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.black
                                ),
                            ),
                            new SizedBox(
                              height: Dimens.gap_dp10,
                            ),
                            new Container(
                              child: Text(
                                  article.desc,
                                  maxLines: 3,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                      fontSize: 14.0,
                                      color: XColors.gray_66
                                  )
                              ),
                            )
                          ],
                        )),

                    new Container(
                        width: 72,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10.0),

                        child: new CachedNetworkImage(
                          width: 72,
                          height: 128,
                          fit: BoxFit.fill,
                          imageUrl: article.envelopePic,
                          placeholder: (BuildContext context, String url) {
                            return new ProgressView();
                          },
                          errorWidget:
                              (BuildContext context, String url, Object error) {
                            return new Icon(Icons.error);
                          },
                        )
                    )
                  ],
                ),
                //底部一排
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          article.author,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: XColors.gray_99
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 6.0),
                        child: new Text(
                          Utils.formatByInt(article.publishTime),
                          style: TextStyle(
                              fontSize: 12.0,
                              color: XColors.gray_99
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          )),
    );
  }
}