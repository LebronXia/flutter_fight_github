import 'package:flutter/material.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/ui/widget/bottom_clipper.dart';

class LoginTopPanel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 300,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class LoginItem extends StatefulWidget {

  const LoginItem({Key key, this.prefixIcon, this.hasSuffixIcon, this.hintText, this.controller}) : super(key: key);

  final IconData prefixIcon;   //图标
  final bool hasSuffixIcon;   //是否有眼睛
  final String hintText;    //hint文字
  final TextEditingController controller;   //控制器

  @override
  State createState() => new _LoginItemState();
}

class _LoginItemState extends State<LoginItem> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new IconButton(
            icon: new Icon(
              widget.prefixIcon,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: null),
        new Expanded(
            child: new TextField(
              obscureText: _obscureText,
              controller: widget.controller,
              style: new TextStyle(color: Colors.grey, fontSize: 16),
              decoration: new InputDecoration(
                hintText: widget.hintText,
                hintStyle: new TextStyle(color: XColors.gray_99, fontSize: 16),
                suffixIcon: widget.hasSuffixIcon ?
                    new IconButton(
                        icon: new Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: XColors.gray_66,
                        ),
                        onPressed: (){
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }) : null,

              ),
            ))
      ],
    );
  }

}