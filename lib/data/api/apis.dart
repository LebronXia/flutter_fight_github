import 'package:flutterfightgithub/common/config.dart';

class GithubApi{
  static const String host = "https://api.github.com/";

  static const String wanAndroidHost = "http://www.wanandroid.com/";

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

  ///趋势 get
  static trendingApi(since, languageType) {
    if (languageType != null) {
      return "https://guoshuyu.cn/github/trend/list?languageType=$languageType&since=${since}";
    }
    return "https://guoshuyu.cn/github/trend/list?since=$since";
  }

  ///趋势项目    TrendingManager
  static getTrendingRepos(String language, String since) {
    return 'https://github-trending-api.now.sh/repositories?language=$language&since=$since';
  }

  ///趋势用户
  static getTrendingUser(String language, String since) {
    return 'https://github-trending-api.now.sh/developers?language=$language&since=$since';
  }

  ///趋势语言
  static getTrendingLanguage() {
    return 'https://github-trending-api.now.sh/languages';
  }

  ///WanAndroid API
  static const String ARTICLE_LIST = "${wanAndroidHost}article/list";

  ///最新项目  0
  static const String NEW_ARTICLE = "${wanAndroidHost}article/listproject";

  ///推荐项目列表   402
  static const String PROJECT_LIST = "${wanAndroidHost}project/list";

  ///查看某个公众号历史数据    int _id = 408;
  static const String WXARTICLE_LIST = "${wanAndroidHost}wxarticle/list";

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

  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }

}