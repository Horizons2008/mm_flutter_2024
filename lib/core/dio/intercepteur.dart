import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final box = GetStorage();
    String token = box.read('token') ?? "";

    if (token != "") {
      options.headers["Authorization"] = "Bearer $token";
    }

    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "application/json";

    print("option header ${options.headers}");

    return super.onRequest(options, handler);
  }

  /*  @override
  Response onResponse(Response response, ResponseInterceptorHandler handler) {
    print("onResponse");
    return response;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response!.statusCode == 401) {
      CommFunc.closeSession();
      print("xyz xyz: ${err.response!.statusCode}");
    }
    return handler.next(err); // <--- THE TIP IS HERE
  }*/
}
