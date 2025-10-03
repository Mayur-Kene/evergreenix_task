import 'dart:io';

import 'package:dio/dio.dart';

import '../local/app_storage.dart';

bool isUnauthorized = false;

class HeaderInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(_headers);
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 && isUnauthorized == false) {
      isUnauthorized = true;
      AppStorage.logout();
    }
    super.onError(err, handler);
  }

  Map<String, String> get _headers {
    Map<String, String> map = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.userAgentHeader: Platform.isAndroid ? "android" : "iPhone",
      'AuthKey': 'test'
    };
    final loggedIn = AppStorage.valueFor(StorageKey.isLoggedIn) ?? false;
    if (loggedIn) {
      final token = AppStorage.valueFor(StorageKey.token) ?? '';
      map[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return map;
  }
}
