import 'package:flutter/material.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/view_model/dynamic_model.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:provider/provider.dart';

/// 主页动态tab页
class DynamicPage extends StatefulWidget {
  @override
  _DynamicPageState createState() => new _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    var model = Provider.of<DynamicModel>(context, listen: false);
//    model.refresh();

  }
  @override
  Widget build(BuildContext context) {
    return new ProviderWidget(
        model: DynamicModel(),
        builder: (BuildContext context, DynamicModel model, Widget child) {
          return Container(
            child: new FlatButton(
                 child: Text(
                   "data"
                 ),
              onPressed: () {
                var userModel = Provider.of<UserModel>(context, listen: false);
                  model.refresh(userModel.user.login);
              },
            ),
          );
        },

    );
  }
}