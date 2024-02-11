import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:master_menu/core/communFunctions.dart';
import 'package:master_menu/screens/login/screenLogin.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        int tt = dioError.response?.statusCode ?? 0;
        message = _handleError(tt, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = "";

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        {
          CommFunc.closeSession();
          CommFunc.showToast(content: "Session Expiré Vous devez reconnecté");
          Get.offAll(ScreenLogin());

          return 'Session Expiré';
        }

      case 404:
        return 'Lien introuvable';

      case 302:
        return 'session expiré ';

      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
