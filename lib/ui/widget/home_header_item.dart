import 'package:flutter/material.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/res/dimens.dart';


class HomeheaderItem extends StatelessWidget {

  const HomeheaderItem(
      {
        this.title,
        this.extra : "更多",
        this.leftIcon,
        this.titleColor,
        Key key
      }): super(key: key);

  final String title;
  final String extra;
  final Color titleColor;
  final IconData leftIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      padding: const EdgeInsets.all(0.0),
      child: new ListTile(
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(
                  leftIcon ?? Icons.whatshot,
                  color: titleColor ?? Colors.redAccent,
              ),
              new SizedBox(height: Dimens.gap_dp5),
              new Container(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16.0
                  ),
                ),
              ),
            ],
          ),
        trailing: new Row(
          //最小
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              extra,
              style: TextStyle(
                color: XColors.gray_66,
                fontSize: 14.0
              ),
            ),
            new Icon(
              Icons.keyboard_arrow_right,
              color: XColors.gray_66,
            )
          ],
        ),
      ),
      //下划横线
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(width: 0.33, color:XColors.divider)
        )
      ),
    );
  }
}