import 'dart:convert';
import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final tUserModel = UserModel(id: 1, username: 'user', email: 'user@user.com');

  test('should be a subclass of User entity', () async {
    // Assert
    expect(tUserModel, isA<User>());
  });

  test('should return a valid User model from JSON response', () async {
    // Arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixture(FixturePaths.userJson));

    // Act
    final result = UserModel.fromJson(jsonMap);

    // Assert
    expect(result, tUserModel);
  });

  test('should return a JSON map from User model', () async {
    // Arrange
    final result = tUserModel.toJson();

    // Act
    final expectedJsonMap = {
      'id': 1,
      'username': 'user',
      'email': 'user@user.com',
    };

    // Assert
    expect(result, expectedJsonMap);
  });
}
