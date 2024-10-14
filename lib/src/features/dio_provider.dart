import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mapesa/src/features/auth_provider.dart';

class DioProvider {
  static final _dio = Dio();
  static DioProvider? _instance;
  Dio get dio => _dio;

  static Future<void> init() async {
    /// Called in the main function to initialize the provider and perform async tasks
    if (_instance != null) {
      throw Exception("DioProvider already initialized");
    }
    _instance = DioProvider._(baseUrl: dotenv.env['BACKEND_URL'] ?? "");
    debugPrint("DioProvider initialized");
  }

  static Future<void> initSafe({required String overrideUrl}) async {
    /// A safe way of initializing the provider within an Isolate
    /// Inside Isolates we don't have access to dotenv
    if (_instance != null) {
      throw Exception("DioProvider already initialized");
    }
    _instance = DioProvider._(baseUrl: overrideUrl);
    debugPrint("DioProvider initialized");
  }

  static DioProvider get instance {
    if (_instance == null) {
      throw Exception(
          "DioProvider not initialized. Call DioProvider.init() before accessing instance");
    }
    return _instance!;
  }

  DioProvider._({required String baseUrl}) {
    _dio.options.baseUrl = baseUrl;
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
      return handler.next(options);
    }, onResponse: (response, handler) {
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
  }

  void debugStringForDioProviderTemplate(
      String message, String url, String serverMessage) {
    debugPrint(
        "Dio Provider Error: $message\nError came up when calling $url\nMessage from server: $serverMessage");
  }

  set baseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  static void nullCheck() {
    assert(_instance != null, true);
    debugPrint("DioProvider null check");
  }
}
