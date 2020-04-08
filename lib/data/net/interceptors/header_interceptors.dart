import 'package:dio/dio.dart';

/**
 * 设置超时时间
 */
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    ///超时
    options.connectTimeout = 30000;

    return options;
  }
}