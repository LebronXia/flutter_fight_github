

import 'package:flutterfightgithub/common/index.dart';
import 'package:flutterfightgithub/data/net/HttpErrorEvent.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return new HttpErrorEvent(code, message);
    }

    //首页进行网络错误的提醒toast
    eventBus.fire(new HttpErrorEvent(code, message));
    return new HttpErrorEvent(code, message);
  }
}

//@override
//String network_error_401 = "[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]";
//@override
//String network_error_403 = "403权限错误";
//@override
//String network_error_404 = "404错误";
//@override
//String network_error_timeout = "请求超时";
//@override
//String network_error_unknown = "其他异常";
//@override
//String network_error = "网络错误";