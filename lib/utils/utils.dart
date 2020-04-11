import 'package:flutter/material.dart';

class Utils {

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }
}