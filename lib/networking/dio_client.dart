import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio _dio = Dio();
  final List<Interceptor>? interceptors;
  DioClient(this.interceptors) {
    _dio.options
      ..baseUrl = 'https://dummyjson.com'
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {'Content-Type': 'application/json'}
      ..validateStatus = (status) {
        return status != null && status < 500;
      };
    if (interceptors != null && interceptors!.isNotEmpty) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ));
    }
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParamters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParamters,
          options: options,
          cancelToken: cancelToken);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path,
      {dynamic body, Options? options, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.post(path,
          data: body, options: options, cancelToken: cancelToken);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String path,
      {dynamic body,
      Map<String, dynamic>? queryParamters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final response = await _dio.put(path,
          data: body,
          queryParameters: queryParamters,
          options: options,
          cancelToken: cancelToken);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path,
      {dynamic body,
      Map<String, dynamic>? queryParamters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final response = await _dio.delete(path,
          data: body,
          queryParameters: queryParamters,
          options: options,
          cancelToken: cancelToken);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Timeout error";
      case DioExceptionType.badResponse:
        final statusCode = error.response!.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case >= 300 && < 400:
              return 'Error';
            case 400:
              return 'Bad Request';
            case 404:
              return 'Not Found';
            case 500:
              return 'Internal Server Error';
          }
        }
        break;
      case DioExceptionType.cancel:
        return 'Cancelled by user';
      case DioExceptionType.unknown:
        return 'No Internet Connection';
      case DioExceptionType.badCertificate:
        return 'Certificate error';
      case DioExceptionType.connectionError:
        return 'Connection error';
      default:
        return 'Unknown Error';
    }
    return 'Unknown Error';
  }
}
