import 'package:capybara_app/data/requests/refresh_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tRefreshRequest = RefreshRequest(refresh: '321');

  test('should return a JSON map from refresh request', () async {
    // Arrange
    final result = tRefreshRequest.toJson();

    // Act
    final expectedJsonMap = {
      'refresh': '321',
    };

    // Assert
    expect(result, expectedJsonMap);
  });
}
