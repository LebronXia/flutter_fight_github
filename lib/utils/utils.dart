import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale curLocale;

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, _scaffoldkey, String msg) {
    _scaffoldkey.currentState.showSnackBar(
      SnackBar(content: Text("$msg")),
    );

  }

  //Loading
  static void showLoading(context, [String text]){
    text = text ?? "Loading.....";
    showDialog(
        barrierDismissible: false,   //点击对话框barrier(遮罩)时是否关闭它
        context: context,
        builder: (context){
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    //阴影
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                    )
                  ]
              ),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              constraints: BoxConstraints(minHeight: 120, minWidth: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,   //表示尽可能少的占用水平空间
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  //圆形图片
  static Widget gmAvatar(String url,{
    //具名参数   foo({int x, int y})
    double width = 30,
    double height,
    BoxFit fit,
    BorderRadius borderRadius,
  }){
    var placeholder = Image.asset(
      "assets/images/avatar-default.png",
      width: width,
      height: height,
    );

    //圆角矩形裁剪
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(2),  ////圆角半径
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  }

  //Toast
  static void showToast(String text, {
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.grey[600],
      fontSize: 16.0,
    );
  }

  ///格式根据时间搓
  static String formatByInt(int timestamp) {
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    return getNewsTimeStr(date);
  }

  ///日期格式转换
  static String getNewsTimeStr(DateTime date) {
    debugPrint(date.toIso8601String());
    int subTimes =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTimes < MILLIS_LIMIT) {
      return (curLocale != null)
          ? (curLocale.languageCode != "zh") ? "right now" : "刚刚"
          : "刚刚";
    } else if (subTimes < SECONDS_LIMIT) {
      return (subTimes / MILLIS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " seconds ago" : " 秒前"
              : " 秒前");
    } else if (subTimes < MINUTES_LIMIT) {
      return (subTimes / SECONDS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " min ago" : " 分钟前"
              : " 分钟前");
    } else if (subTimes < HOURS_LIMIT) {
      return (subTimes / MINUTES_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " hours ago" : " 小时前"
              : " 小时前");
    } else if (subTimes < DAYS_LIMIT) {
      return (subTimes / HOURS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " days ago" : " 天前"
              : " 天前");
    } else {
      return getDateStr(date);
    }
  }

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }
}