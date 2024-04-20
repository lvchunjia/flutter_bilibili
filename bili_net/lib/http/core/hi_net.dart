import 'package:bili_net/http/core/dio_adapter.dart';
import 'package:bili_net/http/core/hi_net_adapter.dart';
import 'package:bili_net/http/request/base_request.dart';
import 'package:flutter/foundation.dart';

import 'hi_error.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  /// 统一请求入口方法
  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
    }
    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(
          code: status ?? -1,
          message: result.toString(),
          data: result,
        );
    }
  }

  /// 统一请求网络方法
  Future<dynamic> send<T>(BaseRequest request) async {
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    if (kDebugMode) {
      print('hi_net:$log');
    }
  }
}
