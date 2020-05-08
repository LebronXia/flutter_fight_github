import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/i10n/localization_intl.dart';
import 'package:flutterfightgithub/data/models/trendrepo.dart';
import 'package:flutterfightgithub/res/style.dart';
import 'package:flutterfightgithub/utils/utils.dart';

class TrendRepoItem extends StatefulWidget {

  TrendRepoItem(this.repo) : super();
  final TrendingReposBean repo;

  @override
  _TrendRepoItemState createState() => new _TrendRepoItemState();
}

class _TrendRepoItemState extends State<TrendRepoItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
      //Material Design 默认的样式风格,我们使用Material作为本路由的根。
      child: Material(
        color: Colors.white,
        //设置特定边界边框
        shape: BorderDirectional(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: .5,
            )
        ),

        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Utils.gmAvatar(
                      widget.repo.avatar,
                      width: 24.0,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                              widget.repo.author,
                              textScaleFactor: .9
                          ),
                        )
                    ),
                    ClipOval(
                      child: Container(
                        color: Colors.redAccent,
                        width: 8.0,
                        height: 8.0,
                      ),
                    ),
                    Gaps.hGap5,
                    Text(widget.repo.language ?? ""),
                  ],
                ),
              ),

              //一个固定高度的行，通常包含一些文本，以及一个行前或行尾图标
//              ListTile(
//                dense: true,
//                leading: Utils.gmAvatar(
//                  widget.repo.avatar,
//                  width: 24.0,
//                  borderRadius: BorderRadius.circular(12),
//                ),
//                title: Text(
//                  widget.repo.author,
//                  textScaleFactor: .9,
//                ),
//                trailing:
//                 Row(
//                  children: <Widget>[
//                    ClipOval(
//                      child: Container(
//                        color: Colors.redAccent,
//                        width: 8.0,
//                        height: 8.0,
//                      ),
//                    ),
//                    Gaps.hGap5,
//                    Text(widget.repo.language ?? ""),
//                  ],
//                )
//
//                //Text(widget.repo.language ?? ""),
//              ),

              //项目标题和简介
              Padding(
                //左右各添加16像素补白
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.repo.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,  //字体粗细
                        fontStyle: FontStyle.normal,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: widget.repo.description == null
                          ? Text(
                        GmLocalizations.of(context).noDescription,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,  //斜体显示
                            color: Colors.grey[700]),
                      )
                          :Text(
                        widget.repo.description,
                        maxLines: 3,
                        style: TextStyle(
                          height: 1.15,
                          color: Colors.blueGrey[700],
                          fontSize: 13,
                        ),
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                         "${widget.repo.currentPeriodStars} stars ",
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 13,
                        ),
                      ),
                    )

                  ],
                ),
              ),
              _buildBottom(widget)
            ],
          ),

        ),
      ),
    );
  }
}

Widget _getBuiltByWidget(TrendRepoItem widget) =>
  Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Text(
        "built by",
        style: TextStyle(
            color: Colors.grey,
            fontSize: 12
        ),
      ),
      SizedBox(
        width: 5.0,
      ),
      Row(
        children: widget.repo.builtBy
            .map((BuiltBy url) =>
            Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Utils.gmAvatar(url.avatar ?? "", width: 14.0 ),
            )
        ).toList(),
      )
    ],
  );

//构建卡片底部信息
Widget _buildBottom(TrendRepoItem widget){
  const paddingWidth = 10;
  ///用于Icon颜色主题
  return IconTheme(
    data: IconThemeData(
        color: Colors.grey,
        size: 15
    ),

    child: DefaultTextStyle(
      style: TextStyle(color: Colors.grey, fontSize: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // ignore: missing_return
        child: Builder(builder: (context){
          var children = <Widget>[
            Icon(Icons.star),
            Text(widget.repo.stars.toString().padRight(paddingWidth)),

            Icon(MyIcons.REPOS_ITEM_FORK), //我们的自定义图标
            Text(widget.repo.forks.toString().padRight(paddingWidth)),

            _getBuiltByWidget(widget),
          ];
          return Row(children: children);

        }),
      ),
    ),
  );
}

