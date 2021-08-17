import 'dart:convert';

import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/utils/constants/api.dart';
import 'package:http/http.dart' as http;

import 'package:capybara_app/data/models/token_model.dart';
import 'package:capybara_app/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the http://? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TokenModel> loginUser(String username, String password);

  /// Calls the http://? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> registerUser(
    String username,
    String email,
    String password,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<TokenModel> loginUser(String username, String password) async {
    final response = await client.post(
      Uri.parse(Api.mainUrl + Api.loginUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) throw ServerException();

    return TokenModel.fromJson(json.decode(response.body));
  }

  @override
  Future<UserModel> registerUser(
      String username, String email, String password) {
    throw UnimplementedError();
  }
}
