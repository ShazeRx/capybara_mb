import 'dart:convert';
import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/http_methods.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/http/http_client.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/data/requests/auth/login_request.dart';
import 'package:capybara_app/data/requests/auth/register_request.dart';

abstract class AuthRemoteDataSource {
  /// Calls the http://? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TokenModel> loginUser(LoginRequest request);

  /// Calls the http://? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> registerUser(RegisterRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient _client;

  AuthRemoteDataSourceImpl({
    required HttpClient client,
  }) : this._client = client;

  @override
  Future<TokenModel> loginUser(LoginRequest request) async {
    final response = await this._client.invoke(
          url: Api.loginUrl,
          method: HttpMethods.post,
          body: request.toJson(),
        );
    return TokenModel.fromJson(json.decode(response));
  }

  @override
  Future<UserModel> registerUser(RegisterRequest request) async {
    final response = await this._client.invoke(
          url: Api.registerUrl,
          method: HttpMethods.post,
          body: request.toJson(),
        );

    return UserModel.fromJson(json.decode(response));
  }
}
