import 'package:dio/dio.dart';
import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/utils/sputils.dart';

/**
 * token拦截器
 */
class TokenInterceptors extends InterceptorsWrapper{
  String _token;

  @override
  Future onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers["Authorization"] = _token;
    return options;
  }

  @override
  Future onResponse(Response response) async{
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = 'token ' + responseJson["token"];
        //获取成功后SpUtil添加token保存
        await SpUtils.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
    //SpUtil移除Token
    SpUtils.remove(Config.TOKEN_KEY);
    //releaseClient();
  }

  ///获取授权token
  getAuthorization() async {
    String token = await SpUtils.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await SpUtils.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }
}