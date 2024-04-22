import 'package:bili_net/db/hi_cache.dart';
import 'package:bili_net/http/core/hi_net.dart';
import 'package:bili_net/http/request/base_request.dart';
import 'package:bili_net/http/request/login_request.dart';
import 'package:bili_net/http/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static _send(
    String userName,
    String password, {
    String? imoocId,
    String? orderId,
  }) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }

    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId ?? "")
        .add("orderId", orderId ?? "");

    var result = await HiNet.getInstance().fire(request);

    print("login/register: $result");
    return result;
  }

  static registration(
    String userName,
    String password,
    String imoocId,
    String orderId,
  ) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
