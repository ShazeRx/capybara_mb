import 'dart:convert';

import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final tTokenModel = TokenModel(refresh: '123', access: '321');

  test('should be a subclass of Token entity', () async {
    // Assert
    expect(tTokenModel, isA<Token>());
  });

  test('should return a valid Token model from JSON response', () async {
    // Arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixture(FixturePaths.tokenJson));

    // Act
    final result = TokenModel.fromJson(jsonMap);

    // Assert
    expect(result, tTokenModel);
  });

  test('should return a JSON map from Token model', () async {
    // Arrange
    final result = tTokenModel.toJson();

    // Act
    final expectedJsonMap = {
      'token': {
        'refresh': '123',
        'access': '321',
      }
    };

    // Assert
    expect(result, expectedJsonMap);
  });
}
