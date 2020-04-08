import 'package:dio/dio.dart';
import 'package:flutterfightgithub/data/net/code.dart';
import 'package:flutterfightgithub/data/net/result_data.dart';

/// 网络结果处理拦截器
class ResponseInterceptors extends InterceptorsWrapper{

  @override
  Future onResponse(Response response) {
    RequestOptions option = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return value;
  }
}