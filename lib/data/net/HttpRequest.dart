import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/common/config.dart';
import 'package:flutterfightgithub/data/net/code.dart';
import 'package:flutterfightgithub/data/net/interceptors/ErrorInterceptors.dart';
import 'package:flutterfightgithub/data/net/interceptors/LogsInterceptors.dart';
import 'package:flutterfightgithub/data/net/interceptors/header_interceptors.dart';
import 'package:flutterfightgithub/data/net/interceptors/response_interceptors.dart';
import 'package:flutterfightgithub/data/net/interceptors/token_interceotors.dart';
import 'package:flutterfightgithub/data/net/result_data.dart';
import 'dart:convert' as convert;


/// 全局的网络请求对象
final HttpRequest httpRequest = new HttpRequest();

class HttpRequest{

  //post请求头部
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = new Dio();

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  HttpRequest(){
    _dio.interceptors.add(new HeaderInterceptors());

    _dio.interceptors.add(_tokenInterceptors);

    _dio.interceptors.add(new LogsInterceptors());

    _dio.interceptors.add(new ErrorInterceptors(_dio));

   // _dio.interceptors.add(new ResponseInterceptors());
  }

//  setBaseUrl(String baseUrl){
//    _baseUrl = baseUrl;
//  }

  get(url,param) async{
    return await request(url, param, null, new Options(method:"GET"));
  }

  post(url,param) async{
    return await request(url, param, {"Accept": 'application/vnd.github.VERSION.full+json'}, new Options(method: 'POST'));
  }

  delete(url,param) async{
    return await request(url, param, null, new Options(method: 'DELETE'));
  }

//  put(url,param) async{
//    return await request(_baseUrl+url, param, null, new Options(method: "PUT", contentType: ContentType.text));
//  }

  Future<ResultData> request(url, params, Map<String, String> header, Options option,
      {noTip = false}) async{

    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    //网络错误处理
    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    //网络请求
    Response response;

    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }

//    if(Config.DEBUG){
//      var jsonString = convert.jsonEncode(response.data);
//      debugPrint(jsonString);
//    }


    ResultData value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return value;
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

