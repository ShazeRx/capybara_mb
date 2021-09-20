import 'dart:convert';

import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/errors/exceptions/client_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:dio/dio.dart';

import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/token_interceptor.dart';

abstract class HttpClient {
  Future<dynamic> invoke({
    required String url,
    required String method,
    Options? options,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });
}

class HttpClientImpl implements HttpClient {
  final Dio _dio;

  HttpClientImpl({
    required Dio dio,
  }) : this._dio = dio {
    this._dio.interceptors.add(TokenInterceptor());
    this._dio.interceptors.add(ErrorInterceptor(invoke: invoke));
    this
        ._dio
        .interceptors
        .add(LoggingInterceptor()); //Only for debugging purpose
  }

  @override
  Future<dynamic> invoke({
    required String url,
    required String method,
    Options? options,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await this._dio.request(
            this._getUrl(url),
            options: this._getOptions(method, options),
            data: body,
            queryParameters: queryParameters,
          );
      return json.encode(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        //TODO - to think about - add handling multiple errors
        final errors = Map.from((e.response!.data)).values.toList();
        throw ClientException(message: errors.first);
      }
      throw ServerException(message: e.message);
    }
  }

  Options _getOptions(String method, Options? options) {
    if (options != null) {
      options.method = method;
      return options;
    }

    return Options(method: method);
  }

  String _getUrl(String url) {
    if (url.contains(Api.baseUrl)) {
      return url;
    }

    return Api.baseUrl + url;
  }
}
