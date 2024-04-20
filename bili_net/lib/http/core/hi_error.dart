///网络异常统一格式类
class HiNetError {
  final int code;
  final String message;
  final dynamic data;
  HiNetError({required this.code, required this.message, this.data});
}

///需要登录的异常
class NeedLogin extends HiNetError {
  NeedLogin({super.code = 401, super.message = '请先登录'});
}

///需要授权的异常
class NeedAuth extends HiNetError {
  NeedAuth(
    String message, {
    super.code = 403,
    dynamic data,
  }) : super(message: '');
}
