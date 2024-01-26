import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mapesa/src/features/auth_provider.dart';
import 'package:mapesa/src/features/cache/common_cache.dart';

class DioProvider {
  static DioProvider? _instance;
  final _dio = Dio();

  DioProvider._() {
    _dio.options.baseUrl = CommonCache.backendURLCache.value;
    _dio.options.connectTimeout = const Duration(minutes: 2);
    _dio.options.receiveTimeout = const Duration(minutes: 2);

    if (AuthProvider.instance.isLoggedIn()) {
      _dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AuthProvider.authToken}',
      };
    }

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // TODO: Log request
      return handler.next(options);
    }, onResponse: (response, handler) {
      // TODO: Log response
      return handler.next(response);
    }, onError: (error, handler) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          debugStringForDioProviderTemplate("Connection timeout",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.connectionTimeout:
          debugStringForDioProviderTemplate("Connection timeout",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.sendTimeout:
          debugStringForDioProviderTemplate("Send timeout",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.receiveTimeout:
          debugStringForDioProviderTemplate("Receive timeout",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.badCertificate:
          debugStringForDioProviderTemplate("Response error",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.badResponse:
          debugStringForDioProviderTemplate("Response error",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.cancel:
          debugStringForDioProviderTemplate("Request cancelled",
              error.response!.realUri.toString(), error.message!);
          break;
        case DioExceptionType.unknown:
          debugStringForDioProviderTemplate("Other error",
              error.response!.realUri.toString(), error.message!);
          break;
      }
      debugPrint("Error: ${error.response?.data}");
      if (error.response?.statusCode == 401) {
        AuthProvider.instance.logoutUser();
      }
      return handler.next(error);
    }));

    _instance = this;
  }

  static DioProvider get instance => _instance ?? DioProvider._();

  void debugStringForDioProviderTemplate(
      String message, String url, String serverMessage) {
    debugPrint(
        "Dio Provider Error: $message\nError came up when calling $url\nMessage from server: $serverMessage");
  }

  Dio get dio => _dio;
}
