import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'header_interceptor.dart';
import 'logging_interceptor.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient _client = ApiClient._();

  static ApiClient get client => _client;

  static final String _baseUrl = 'http://demo.marinecareerlink.com/api/';

  final _dio = Dio()
    ..options = BaseOptions(
      baseUrl: _baseUrl,
    )
    ..interceptors.add(HeaderInterceptor())
    ..interceptors.add(LoggingInterceptor());

  Future<dynamic> get(String endpoint, {Map<String, dynamic> query = const {}}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final response = await _dio.post(endpoint, data: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final response = await _dio.put(endpoint, data: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint, {dynamic body}) async {
    try {
      final response = await _dio.delete(endpoint, data: body != null ? jsonEncode(body) : null);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> multipart(String endpoint,
      {Map<String, String> body = const {}, Map<String, String> files = const {}}) async {
    try {
      Map<String, dynamic> request = {};

      if (body.isNotEmpty) request.addAll(body);

      if (files.isNotEmpty) {
        for (MapEntry element in files.entries) {
          request[element.key] = await MultipartFile.fromFile(element.value,
              filename: element.value.toString().split("/").last);
        }
      }

      var form = FormData.fromMap(request);

      final response = await _dio.post(endpoint, data: form);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return Future.error(response.data['message']);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<dynamic> _handleError(dynamic e) {
    if (e is DioException) {
      final response = e.response?.data;

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return Future.error("Connection timed out. Please check your internet and try again.");
        case DioExceptionType.sendTimeout:
          return Future.error("Request timed out while sending data. Please try again.");
        case DioExceptionType.receiveTimeout:
          return Future.error("Response timed out. The server took too long to respond.");
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400:
              return Future.error(
                  response?['error'] ?? "Invalid request. Please check your input.");
            case 401:
              return Future.error("Unauthorized. Please log in again.");
            case 403:
              return Future.error("Access denied. You don’t have permission.");
            case 404:
              return Future.error("Requested resource not found.");
            case 409:
              return Future.error("Conflict error. Duplicate or invalid state.");
            case 422:
              return Future.error("Validation error. Please check your inputs.");
            case 500:
              return Future.error(
                  response?['message'] ?? "Internal server error. Please try again later.");
            case 503:
              return Future.error("Service unavailable. Try again later.");
            default:
              return Future.error(
                  response?['message'] ?? "Unexpected server error. Please try again.");
          }

        case DioExceptionType.cancel:
          return Future.error("Request was cancelled.");

        case DioExceptionType.connectionError:
          return Future.error("No internet connection. Please check your network.");

        case DioExceptionType.unknown:
        default:
          return Future.error("Unexpected error occurred. Please try again. (${e.message})");
      }
    } else {
      return Future.error("Something went wrong. Please try again.");
    }
  }
}
