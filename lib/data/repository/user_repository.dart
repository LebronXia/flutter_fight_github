import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/data/api/apis.dart';
import 'package:flutterfightgithub/data/net/HttpRequest.dart';
import 'package:flutterfightgithub/data/net/data_result.dart';
import 'package:flutterfightgithub/data/net/result_data.dart';
import 'package:flutterfightgithub/utils/sputils.dart';

class UserRepository{

  ///登录
  static login(username, password) async{
    String type = username + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);

    await SpUtils.save(Config.USER_NAME_KEY, username);
    await SpUtils.save(Config.USER_BASIC_CODE, base64Str);

    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": Config.CLIENT_ID,
      "client_secret": Config.CLIENT_SECRET
    };
    httpRequest.clearAuthorization();

    ResultData res = await httpRequest.request(GithubApi.AUTHORIZATION, json.encode(requestParams),
        null, new Options(method: "post"));
    if (res != null && res.result) {
      ResultData resultData = await getUserInfo(null);
    }

    return DataResult(ResultData, res.result);
  }

  ///获取个人信息
  static getUserInfo(userName) async{
    var res;
    if(userName == null){
      res = await httpRequest.request(GithubApi.MYUSERINFO, null, null, null);
    } else {
      res = await httpRequest.request(GithubApi.MYUSERINFO, null, null, null);
    }
    if(res != null && res.result){
      String starred = "---";
    }
  }
}
