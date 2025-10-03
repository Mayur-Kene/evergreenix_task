


import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // final pretty = const JsonEncoder.withIndent('  ').convert(response.data);
    log('REQUEST =>  ${response.requestOptions.data}');
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}');
    _printFormattedJson(response.data);
    super.onResponse(response, handler); // Continue with the response
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    log('REQUEST: ${err.response?.requestOptions.data}');
    _printFormattedJson(err.response?.data);
    super.onError(err, handler); // Continue with the error
  }

  void _printFormattedJson(dynamic jsonData) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final prettyJson = encoder.convert(jsonData);
    log(prettyJson);
  }
}
