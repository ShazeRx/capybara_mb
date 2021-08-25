import 'dart:convert';

import 'package:capybara_app/data/models/refresh_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tRefreshModel = RefreshModel(access: '321');

  test('should return a valid Refresh model from JSON response', () async {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('refresh.json'));

    // Act
    final result = RefreshModel.fromJson(jsonMap);

    // Assert
    expect(result, tRefreshModel);
  });

  test('should return a JSON map from Refresh model', () async {
    // Arrange
    final result = tRefreshModel.toJson();

    // Act
    final expectedJsonMap = {
      'access': '321',
    };

    // Assert
    expect(result, expectedJsonMap);
  });
}
