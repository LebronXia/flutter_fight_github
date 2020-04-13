import 'package:flutter/material.dart';
import 'package:flutterfightgithub/data/repository/user_repository.dart';
import 'package:flutterfightgithub/provider/provider_widget.dart';
import 'package:flutterfightgithub/res/colors.dart';
import 'package:flutterfightgithub/res/dimens.dart';
import 'package:flutterfightgithub/ui/widget/login_widget.dart';
import 'package:flutterfightgithub/utils/utils.dart';
import 'package:flutterfightgithub/view_model/login_model.dart';
import 'package:flutterfightgithub/widget/round_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();
  UserRepository userRepository = new UserRepository();
  // 需要设置Scaffold的key才能弹出SnackBar
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    LoginModel _loginModel = LoginModel(Provider.of(context));

    void _userLogin(_loginModel) {
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      //LoginModel _loginModel = Provider.of<LoginModel>(context);

      if(username.isEmpty || username.length < 6){
        Utils.showSnackBar(context, _scaffoldkey, username.isEmpty ? "请输入用户名" : "用户名至少6位");
        return;
      }

      if(password.isEmpty || password.length < 6){
        Utils.showSnackBar(context, _scaffoldkey, password.isEmpty ? "请输入密码" : "密码至少6位");
        return;
      }

      Utils.showLoading(context);

      _loginModel.login(username, password)
          .then((value) {
        if(value){
          Navigator.of(context).pop();
          Utils.showSnackBar(context, _scaffoldkey, "登录成功～");
        } else {
          // 隐藏loading框
          Navigator.of(context).pop();
          Utils.showSnackBar(context, _scaffoldkey ,"登录失败～");
        }
      });

    }

    return new GestureDetector(
      child: Scaffold(
        key: _scaffoldkey,
        body: new Container(
          child: Stack(
            children: <Widget>[
              LoginTopPanel(),

              new Container(
                margin: const EdgeInsets.only(top: 40.0),
                child: Image.asset(
                    Utils.getImgPath("pic_denglu_toux"),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitWidth,
                    colorBlendMode: BlendMode.srcIn,
                  alignment: Alignment.center,
                ),
              ),

              new Center(
                child: SafeArea(
                    child: ChangeNotifierProvider.value(
                      value: _loginModel,
                      child: new Card(
                        elevation: 5.0,  //正常情况下浮动的距离
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        color: Colors.white,
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0),

                        child:
                        new Padding(
                            padding: new EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 10),
                            child: new Container(
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
                                      _userLogin(_loginModel);
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
                            )
                        ),
                      ),
                    )
              ),
              )
            ],
          ),
        ),
      ),
    );
  }

}