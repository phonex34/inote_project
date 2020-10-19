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

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options) async {
    print("--> ${options.method} ${options.path}");
    print("Content type: ${options.contentType}");
    print("<-- END HTTP -->");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }
    print("<-- END HTTP");

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("<-- Error -->");
    print(err.request);
    print(err.response);
    print(err.error);
    print(err.message);
    print("<-- End error  -->");
    return super.onError(err);
  }
}

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  var _cache = new Map<Uri, Response>();

  @override
  Future onResponse(Response response) {
    _cache[response.request.uri] = response;
    return super.onResponse(response);
  }

  @override
  onError(DioError e) {
    print('onError: $e');
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.DEFAULT) {
      var cachedResponse = _cache[e.request.uri];
      if (cachedResponse != null) {
        return super.onResponse(cachedResponse);
      }
    }
    return super.onError(e);
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
  // @override
  // Future<dynamic> onResponse(Response options) async {
  //   if (options.headers.value("verifyToken") != null) {
  //     //if the header is present, then compare it with the Shared Prefs key
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var verifyToken = prefs.get("VerifyToken");

  //     // if the value is the same as the header, continue with the request
  //     if (options.headers.value("verifyToken") == verifyToken) {
  //       return options;
  //     }
  //   }

  //   return DioError(request: options.request, message: "User is no longer active");
  // }
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
