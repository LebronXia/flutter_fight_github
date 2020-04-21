import 'package:flutter/material.dart';
import 'package:flutterfightgithub/common/i10n/localization_intl.dart';
import 'package:flutterfightgithub/common/route/route_manager.dart';
import 'package:flutterfightgithub/res/style.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //移除顶部padding
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(), //构建抽屉菜单头部
            Expanded(child: _buildMenus()), //构建功能菜单
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            width: double.infinity,
            child: new Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipOval(
                        // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                        child: value.hasUser
                            ? Utils.gmAvatar(value.user.avatarUrl, width: 80)
                            : Image.asset(
                          "imgs/avatar-default.png",
                          width: 60,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          value.hasUser
                              ? value.user.login
                              : GmLocalizations.of(context).login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Offstage(
                          offstage: !value.hasUser,
                          child: Text(
                            value.user.blog,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                    ),
                  ],
                ),

                new Align(
                  alignment: Alignment.topRight,
                  child: new IconButton(
                      icon: new Icon(Icons.edit, color: Colors.white),
                      onPressed: (){
                          Utils.showToast("编辑用户信息~");
                      }),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.hasUser)
              Navigator.of(context).pushNamed(RouteName.login);
          },
        );
      },
    );
  }

  // 构建菜单项
  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(MyIcons.trend_icon),
              title: Text(gm.trend),
              onTap: () => Navigator.pushNamed(context, RouteName.trend),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              //onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              //onTap: () => Navigator.pushNamed(context, "language"),
            ),
            Offstage(
              offstage: !userModel.hasUser,
              child: ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(gm.logout),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      //退出账号前先弹二次确认窗
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(gm.cancel),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text(gm.yes),
                            onPressed: () {
                              //该赋值语句会触发MaterialApp rebuild
                              userModel.clearUser();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )

          ],
        );
      },
    );
  }
}