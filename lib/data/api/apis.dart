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

}