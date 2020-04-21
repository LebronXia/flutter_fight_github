class Config{

  static bool DEBUG = true;

  static const USER_NAME_KEY = "user-name";
  static const TOKEN_KEY = "token";
  static const USER_BASIC_CODE = "user-basic-code";
  static const API_TOKEN = "4d65e2a5626103f92a71867d7b49fea0";

  static const String CLIENT_ID = 'f1be507d4f35189e6a86';
  static const String CLIENT_SECRET ='e2d5a8159e31c09ca61d89faa65a793284ee2a5d';

  static const PAGE_SIZE = 20;
}

//页面状态
class MyLoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}