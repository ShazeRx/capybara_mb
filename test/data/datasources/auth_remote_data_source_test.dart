import 'dart:convert';

import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/utils/constants/api.dart';
import 'package:capybara_app/data/models/token_model.dart';
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

  void mockHttpPost200Success() {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer(
      (_) async => http.Response(fixture('token.json'), 200),
    );
  }

  void mockHttpPost500Failure() {
    when(() => mockHttpClient.post(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 500));
  }

  final tUsername = 'user';
  final tPassword = 'user123';
  final tTokenModel = TokenModel.fromJson(json.decode(fixture('token.json')));

  group('login user', () {
    test(
        'should perform a POST request on a URL with login being the endpoint and with application/json header',
        () {
      // Arrange
      mockHttpPost200Success();

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
      mockHttpPost200Success();

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
}
