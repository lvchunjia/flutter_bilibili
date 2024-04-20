import 'package:bili_net/http/core/hi_net_adapter.dart';
import 'package:bili_net/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse<T>(
        data: {"code": 0, "message": 'success'} as T,
        request: request,
        statusCode: 403,
      );
    });
  }
}
