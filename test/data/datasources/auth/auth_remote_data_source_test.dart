import 'dart:convert';

import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/http_methods.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/http/http_client.dart';
import 'package:capybara_app/data/models/token_model.dart';
import 'package:capybara_app/data/models/user_model.dart';

import 'package:capybara_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:capybara_app/data/requests/login_request.dart';
import 'package:capybara_app/data/requests/register_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

class FakeUri extends Fake implements Uri {}

void main() {
  late AuthRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue<Uri>(FakeUri());
  });

  final tUsername = 'user';
  final tEmail = 'user@user.com';
  final tPassword = 'user123';
  final tTokenModel = TokenModel.fromJson(json.decode(fixture('token.json')));
  final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));
  final tLoginRequest = LoginRequest(username: tUsername, password: tPassword);
  final tRegisterRequest =
      RegisterRequest(username: tUsername, email: tEmail, password: tPassword);

  void mockHttpPostLogin200Success() {
    when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.post,
          body: tLoginRequest.toJson(),
        )).thenAnswer((_) async => fixture('token.json'));
  }

  void mockHttpPostRegister200Success() {
    when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.post,
          body: tRegisterRequest.toJson(),
        )).thenAnswer((_) async => fixture('user.json'));
  }

  void mockHttpPostLogin500Failure() {
    when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.post,
          body: tLoginRequest.toJson(),
        )).thenThrow(ServerException(message: 'An exception occured'));
  }

  void mockHttpPostRegister500Failure() {
    when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.post,
          body: tRegisterRequest.toJson(),
        )).thenThrow(ServerException(message: 'An exception occured'));
  }

  group('login user', () {
    test('should perform a POST request on a URL with login being the endpoint',
        () {
      // Arrange
      mockHttpPostLogin200Success();

      // Act
      dataSource.loginUser(tLoginRequest);

      // Assert
      verify(
        () => mockHttpClient.invoke(
          url: Api.loginUrl,
          method: HttpMethods.post,
          body: tLoginRequest.toJson(),
        ),
      );
    });

    test('should return TokenModel when the response code is 200 (success)',
        () async {
      // Arrange
      mockHttpPostLogin200Success();

      // Act
      final result = await dataSource.loginUser(tLoginRequest);

      // Assert
      expect(result, equals(tTokenModel));
    });

    test('should throw a ServerException for all error codes', () async {
      // Arrange
      mockHttpPostLogin500Failure();

      // Act
      final call = dataSource.loginUser;

      // Assert
      expect(
          () => call(tLoginRequest), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('register user', () {
    test(
        'should perform a POST request on a URL with register being the endpoint',
        () {
      // Arrange
      mockHttpPostRegister200Success();

      // Act
      dataSource.registerUser(tRegisterRequest);

      // Assert
      verify(
        () => mockHttpClient.invoke(
          url: Api.registerUrl,
          method: HttpMethods.post,
          body: tRegisterRequest.toJson(),
        ),
      );
    });

    test('should return UserModel when the response code is 200 (success)',
        () async {
      // Arrange
      mockHttpPostRegister200Success();

      // Act
      final result = await dataSource.registerUser(tRegisterRequest);

      // Assert
      expect(result, equals(tUserModel));
    });

    test('should throw a ServerException for all error codes', () async {
      // Arrange
      mockHttpPostRegister500Failure();

      // Act
      final call = dataSource.registerUser;

      // Assert
      expect(() => call(tRegisterRequest),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
}
