import 'package:flutter/material.dart';
import 'package:flutterfightgithub/res/dimens.dart';

class MyIcons{

  static const String FONT_FAMILY = 'myIconFont';

  static const IconData REPOS_ITEM_FORK = const IconData(0xe67e, fontFamily: MyIcons.FONT_FAMILY);
  static const IconData pageEmpty = IconData(0xe63c, fontFamily: MyIcons.FONT_FAMILY);
  static const IconData pageError = IconData(0xe600, fontFamily: MyIcons.FONT_FAMILY);
  static const IconData pageNetworkError = IconData(0xe678, fontFamily: MyIcons.FONT_FAMILY);
  static const IconData trend_icon = const IconData(0xe818, fontFamily: MyIcons.FONT_FAMILY);
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);

  static Widget getHGap(double w) {
    return SizedBox(width: w);
  }

  static Widget getVGap(double h) {
    return SizedBox(height: h);
  }
}