import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapesa/src/features/cache/common_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapesa/src/models/users.dart';

// modules handles authentication

enum UserLoginStatus {
  success,
  incorrectPassword,
  userNotFound,
  internalServerError,
  unknown,
}

class AuthProvider extends ChangeNotifier {
  static AuthProvider? _instance;
  static User? _loggedInUser;
  static String? _authToken;
  late Dio _dio;

  AuthProvider._() {
    _getUserDetailsFromPersist();
    _getAuthTokenFromPersist();
    _dio = Dio(
      BaseOptions(
          baseUrl: CommonCache.backendURLCache.value,
          headers: {
            "Content-Type": "application/json",
          },
          connectTimeout: const Duration(minutes: 4),
          receiveTimeout: const Duration(minutes: 4)),
    );
    _instance = this;
  }

  static AuthProvider get instance => _instance ?? AuthProvider._();

  static User? get loggedInUser => _loggedInUser;

  static String? get authToken => _authToken;

  bool isLoggedIn() {
    return _loggedInUser != null && _authToken != null;
  }

  Future<User?> createNewUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      "/users/sign-up",
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode != 200) {
      return null;
    }
    final user = User.fromApi(response.data);
    return user;
  }

  Future<(UserLoginStatus, User?)> loginUser({
    required String username,
    required String password,
  }) async {
    Response? response;
    try {
      response = await _dio.post(
        "/users/sign-in",
        data: {
          "subject": username,
          "password": password,
        },
      );
    } on DioException catch (e) {
      var response = e.response;
      debugPrint("[E: ${response?.statusCode}] : ${response?.data}");
      if (response?.statusCode == 400) {
        if (response?.data["message"] == "incorrect_password") {
          return (UserLoginStatus.incorrectPassword, null);
        } else if (response?.data["message"] == "user_not_found") {
          return (UserLoginStatus.userNotFound, null);
        }
      } else if (e.response?.statusCode == 500) {
        return (UserLoginStatus.internalServerError, null);
      }
    }

    if (response == null || response.statusCode != 200) {
      return (UserLoginStatus.unknown, null);
    }

    // if response code is 200 we no need  add checks

    final user = User.fromApi(response.data);
    _loggedInUser = user;
    _authToken = response.data["token"];

    await _writeUserDetailsToPersist(user);
    await _writeAuthTokenToPersist(_authToken!);

    notifyListeners();
    return (UserLoginStatus.success, user);
  }

  Future<void> logoutUser() async {
    _loggedInUser = null;
    _authToken = null;
    notifyListeners();
  }

  Future<void> _getUserDetailsFromPersist() async {
    final prefs = await SharedPreferences.getInstance();
    final claims = prefs.getString("user");
    if (claims != null) {
      _loggedInUser = User.fromJson(jsonDecode(claims));
      notifyListeners();
    }
  }

  Future<void> _writeUserDetailsToPersist(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(user.toJson()));
  }

  Future<void> _writeAuthTokenToPersist(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> _getAuthTokenFromPersist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null) {
      _authToken = token;
    }
  }
}
