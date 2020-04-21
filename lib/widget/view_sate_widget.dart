import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/res/dimens.dart';
import 'package:flutterfightgithub/res/style.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/widget/widget.dart';

///加载中
class ProgressWidget extends StatelessWidget{

  final bool visibility;

  ProgressWidget({
    Key key,
    this.visibility = true,
}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    //当offstage为true,child不会绘制到屏幕上,不会响应点击事件,也不会占用空间;
    //当offstage为false,child绘制到屏幕上;
    return Offstage(
      offstage: (!visibility),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

//界面状态
class StatusViews extends StatelessWidget {
  final int status;
  final GestureTapCallback onTap;

  const StatusViews(this.status, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      switch(status){
        case MyLoadStatus.fail:
          return new Container(
            width: double.infinity,
            child: new Material(
              color: Colors.white,
              //水波纹点击效果
              child: new InkWell(
                onTap: onTap,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(MyIcons.pageError, size: 100, color: Colors.grey),
                    Gaps.vGap10,
                    new Text(
                      "网络貌似不给力,点击重试~",
                      style: TextStyle(
                        fontSize: Dimens.font_sp14,
                        color: XColors.gray_99,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
        case MyLoadStatus.empty:
          return new Container(
            color: Colors.white,
            width: double.infinity,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(MyIcons.pageEmpty, size: 100, color: Colors.grey),
                  Gaps.vGap10,
                  new Text(
                    "空空如也～",
                    style: TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: XColors.gray_99,
                    ),
                  ),
                ],
              ),
            ),
          );
          break;
        case MyLoadStatus.loading:
          return new Container(
            alignment: Alignment.center,
            color: XColors.gray_f0,
            child: new ProgressView(),
          );
          break;
        default:
          return Container(
            width: 0.0,
            height: 0.0,
          );
          break;
      }
  }

}


