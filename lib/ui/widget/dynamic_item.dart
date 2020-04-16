import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/models/event.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/utils/utils.dart';

class DynamicItem extends StatefulWidget {

  DynamicItem(this.event) : super(key: ValueKey(event.id));
  final Event event;

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
        leading:  Utils.gmAvatar(
          widget.event.actor.avatarUrl,
          width: 24.0,
          borderRadius: BorderRadius.circular(12),
        ),
        title: new Row(
          children: <Widget>[
            new Text(
              widget.event.actor.login,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            new Text(
              " star了 ",
              style: TextStyle(
                color: XColors.gray_66,
                fontSize: 12.0,
              ),
            ),
            Expanded(
              child: new Text(
                widget.event.repo.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            )

          ],
        ),
        subtitle: Text(
          Utils.getNewsTimeStr(DateTime.parse(widget.event.createdAt)),
          style: TextStyle(
            color: Colors.blueGrey[700],
            fontSize: 13,
          ),

        )


      )
    );
  }
}