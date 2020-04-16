import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///加载中
class ProgressWidget extends StatelessWidget{

  final bool visibility;

  ProgressWidget({
    Key key,
    this.visibility = true,
}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: (!visibility),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}