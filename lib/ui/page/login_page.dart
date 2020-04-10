import 'package:flutter/material.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/res/dimens.dart';
import 'package:flutterfightgithub/ui/widget/login_widget.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/widget/round_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Scaffold(
        body: new Container(
          child: Stack(
            children: <Widget>[
              LoginTopPanel(),

              new Container(
                child: Image.asset(
                    Utils.getImgPath("pic_denglu_toux"),
                    width: 130,
                    height: 130,
                    fit: BoxFit.fitWidth,
                    colorBlendMode: BlendMode.srcIn,
                ),
              ),

              new Center(
                child: SafeArea(
                    child: new Card(
                      elevation: 5.0,  //正常情况下浮动的距离
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: Colors.white,
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0),

                      child: new Padding(
                        padding: new EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 10),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,  //主轴方向上的对齐方式
                          mainAxisSize: MainAxisSize.min,  //在主轴方向占有空间的值
                          children: <Widget>[
                            LoginItem(
                              controller: _controllerName,
                              prefixIcon: Icons.person,
                              hasSuffixIcon: false,
                              hintText: "用户名",
                            ),
                            LoginItem(
                              controller: _controllerPwd,
                              prefixIcon: Icons.lock,
                              hasSuffixIcon: true,
                              hintText: "密码",
                            ),
                            new RoundButton(
                              text: "登录",
                              margin: EdgeInsets.only(top: 20),
                              onPressed: (){
                              },
                            ),
                            new Container(
                              padding: EdgeInsets.only(top: Dimens.gap_dp15),
                              alignment: Alignment.center,
                              child: new InkWell(
                                  child: new Text(
                                    "欢迎登录",
                                    style: new TextStyle(
                                      color: XColors.gray_99,
                                      fontSize: Dimens.font_sp14
                                    ),
                                  ),
                              ) ,
                            )
                          ],
                          ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}