import 'package:flutterfightgithub/common/config.dart';

class GithubApi{
  static const String host = "https://api.github.com/";

  //获取授权
  static const String AUTHORIZATION = "${host}authorizations";

  //我的用户信息
  static const String MYUSERINFO = "${host}user";

  //用户信息 get
  static String getUserInfo(userName) {
    return "${host}users/$userName";
  }

  //用户项目列表、
  static String getRepos(){
    return "${host}user/repos";
  }

  ///主页动态
  static getEventReceived(userName) {
    return "${host}users/$userName/received_events";
  }

  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }

}