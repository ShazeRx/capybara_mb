import 'dart:convert';

import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/data/models/token_model.dart';
import 'package:capybara_app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:capybara_app/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late AuthRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue<Uri>(FakeUri());
  });

  void mockHttpPostLogin200Success() {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response(fixture('token.json'), 200),
    );
  }

  void mockHttpPostRegister200Success() {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response(fixture('user.json'), 200),
    );
  }

  void mockHttpPost500Failure() {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 500));
  }

  final tUsername = 'user';
  final tEmail = 'user@user.com';
  final tPassword = 'user123';
  final tTokenModel = TokenModel.fromJson(json.decode(fixture('token.json')));
  final tUserModel = UserModel.fromJson(json.decode(fixture('user.json')));

  group('login user', () {
    test(
        'should perform a POST request on a URL with login being the endpoint and with application/json header',
        () {
      // Arrange
      mockHttpPostLogin200Success();

      // Act
      dataSource.loginUser(tUsername, tPassword);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse(Api.mainUrl + Api.loginUrl),
            headers: {'Content-Type': 'application/json'},
          ));
    });

    test('should return TokenModel when the response code is 200 (success)',
        () async {
      // Arrange
      mockHttpPostLogin200Success();

      // Act
      final result = await dataSource.loginUser(tUsername, tPassword);

      // Assert
      expect(result, equals(tTokenModel));
    });

    test(
        'should throw a ServerException when the response code is 500 or other than 200',
        () async {
      // Arrange
      mockHttpPost500Failure();

      // Act
      final call = dataSource.loginUser;

      // Assert
      expect(() => call(tUsername, tPassword),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('register user', () {
    test(
        'should perform a POST request on a URL with register being the endpoint and with application/json header',
        () {
      // Arrange
      mockHttpPostRegister200Success();

      // Act
      dataSource.registerUser(tUsername, tEmail, tPassword);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse(Api.mainUrl + Api.registerUrl),
            headers: {'Content-Type': 'application/json'},
          ));
    });

    test('should return UserModel when the response code is 200 (success)',
        () async {
      // Arrange
      mockHttpPostRegister200Success();

      // Act
      final result = await dataSource.registerUser(tUsername, tEmail, tPassword);

      // Assert
      expect(result, equals(tUserModel));
    });

    test(
        'should throw a ServerException when the response code is 500 or other than 200',
        () async {
      // Arrange
      mockHttpPost500Failure();

      // Act
      final call = dataSource.registerUser;

      // Assert
      expect(() => call(tUsername, tEmail, tPassword),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
}
