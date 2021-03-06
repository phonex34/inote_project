import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioRepository {
  // static String baseURL = Config.baseURL;
  static const baseURL = "https://gorest.co.in/";
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: baseURL,
    // connectTimeout: 30000,
    // receiveTimeout: 20000,
    // headers: {"access-token": token_key},
  );
  static final DioRepository _dioClient = DioRepository._internal();
  Dio _dio = new Dio(baseOptions);
  Dio get dio => _dio;

  factory DioRepository() {
    return _dioClient;
  }
  DioRepository._internal() {
    //TODO:not need will enable if need
    // _dio.interceptors.add(CacheInterceptor());
    // _dio.interceptors.add(AliceClient().alice.getDioInterceptor());
    // _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(AppInterceptors());
  }
}

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    return super.onRequest(options);
  }

  @override
  Future<dynamic> onError(DioError err) {
    if (err.error is SocketException) {
      final error = DioError(
          request: err.request,
          type: DioErrorType.CONNECT_TIMEOUT,
          response: err.response,
          error: err.error);
      return super.onError(error);
    }
    //TODO: not need will enable if need
    if (err.message.contains("ERROR_001")) {
      // this will push a new route and remove all the routes that were present
      // navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
    }

    //Signout system when get code 401
    if (err != null && err.response != null && err.response.statusCode == 401) {
      Get.snackbar('Unauthen', 'Hết hạn đang nhập');
    }

    if (err != null &&
        err.response != null &&
        err.response.statusCode == 404) {}
    return super.onError(err);
  }

  //TODO:not need will enable if need
  @override
  Future<dynamic> onResponse(Response options) async {
    // if (options.headers.value("verifyToken") != null) {
    //   //if the header is present, then compare it with the Shared Prefs key
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var verifyToken = prefs.get("VerifyToken");

    //   // if the value is the same as the header, continue with the request
    //   if (options.headers.value("verifyToken") == verifyToken) {
    //     return options;
    //   }
    // }
    if (options.data['code'] == 401) {
      if (!Get.isDialogOpen) {
        Get.snackbar('Unauthen', 'Hết hạn đang nhập',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 10));
      }
    }
    // return DioError(
    //     request: options.request, message: "User is no longer active");
    super.onResponse(options);
  }
}

extension DioErrroExtenion on DioError {
  String get messageResponse {
    final errors = this.response.data["errors"];
    String errorMess = "";
    if (errors != null) {
      errors.forEach((k, v) {
        print('$k: $v');
        errorMess += "$v \n";
      });
    }
    return errorMess;
  }

  Map<String, String> get errorList {
    final errors = this.response.data["errors"];
    final Map<String, String> data = new Map<String, String>();
    if (errors != null) {
      errors.forEach((k, v) {
        print('$k: $v');
        data[k] = v;
      });
    }
    return data;
  }
}
