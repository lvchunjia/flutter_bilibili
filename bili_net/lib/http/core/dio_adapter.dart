import 'package:bili_net/http/core/hi_error.dart';
import 'package:bili_net/http/core/hi_net_adapter.dart';
import 'package:bili_net/http/request/base_request.dart';
import 'package:dio/dio.dart';

///Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    Response? response;
    DioException? error;
    var options = Options(headers: request.header);

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(
          request.url(),
          options: options,
          data: request.params,
        );
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(
          request.url(),
          options: options,
          data: request.params,
        );
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw HiNetError(
        code: response?.statusCode ?? -1,
        message: error.toString(),
        data: buildRes(response, request),
      );
    }

    return buildRes(response, request);
  }

  Future<HiNetResponse<T>> buildRes<T>(
    Response? response,
    BaseRequest request,
  ) {
    return Future.value(HiNetResponse<T>(
      data: response?.data,
      request: request,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
      extra: response,
    ));
  }
}
