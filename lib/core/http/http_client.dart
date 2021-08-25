import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/errors/exceptions/network_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/http/interceptors/error_interceptor.dart';
import 'package:capybara_app/core/http/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';

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
            Api.baseUrl + url,
            options: this._getOptions(method, options),
            data: body,
            queryParameters: queryParameters,
          );
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        throw ServerException(message: e.response!.data['message']);
      }
      throw NetworkException();
    }
  }

  Options _getOptions(String method, Options? options) {
    if (options != null) {
      options.method = method;
      return options;
    }

    return Options(method: method);
  }
}
