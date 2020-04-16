import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutterfightgithub/utils/utils.dart';

class DynamicItem extends StatefulWidget {
  @override
  _DynamicItemState createState() => new _DynamicItemState();
}

class _DynamicItemState extends State<DynamicItem> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        dense: true,
        leading: Image(
          image: AssetImage(
              Utils.getImgPath('ali_connors')
          )
        ),
        title: Text(
          "hahahahahha",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "hahahahha",
          style: TextStyle(
            color: Colors.blueGrey[700],
            fontSize: 13,
          ),

        ),
        trailing: Text(
          "星象"
        ),


      )
    );
  }
}