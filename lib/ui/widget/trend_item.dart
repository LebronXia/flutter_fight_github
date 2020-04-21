import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/i10n/localization_intl.dart';
import 'package:flutterfightgithub/data/models/TrendingRepoModel.dart';
import 'package:flutterfightgithub/res/style.dart';
import 'package:flutterfightgithub/utils/utils.dart';

class TrendItem extends StatefulWidget {

  TrendItem(this.trend) : super();
  final TrendingRepoModel trend;

  @override
  _TrendItemState createState() => new _TrendItemState();
}

class _TrendItemState extends State<TrendItem> {
  @override
  Widget build(BuildContext context) {
    var subtitle;

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
              //一个固定高度的行，通常包含一些文本，以及一个行前或行尾图标
              ListTile(
                dense: true,
                leading: Utils.gmAvatar(
                  widget.trend.contributorsUrl,
                  width: 24.0,
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  widget.trend.name,
                  textScaleFactor: .9,
                ),
                subtitle: subtitle,
                trailing: Text(widget.trend.language ?? ""),
              ),

              //项目标题和简介
              Padding(
                //左右各添加16像素补白
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.trend.reposName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,  //字体粗细
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      child: widget.trend.description == null
                          ? Text(
                        GmLocalizations.of(context).noDescription,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,  //斜体显示
                            color: Colors.grey[700]),
                      )
                          :Text(
                        widget.trend.description,
                        maxLines: 3,
                        style: TextStyle(
                          height: 1.15,
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

//构建卡片底部信息
Widget _buildBottom(TrendItem widget){
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
            Text(" " +
                widget.trend.starCount
                    .toString()
                    .padRight(paddingWidth)),

            //我们的自定义图标
            Icon(MyIcons.REPOS_ITEM_FORK),
            new Expanded(
                child: Text(widget.trend.forkCount.toString().padRight(paddingWidth)),
            ),
           Text(widget.trend.meta)
          ];

          return Row(children: children);

        }),
      ),

    ),
  );
}