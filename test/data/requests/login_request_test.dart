import 'package:capybara_app/data/requests/login_request.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tLoginRequest = LoginRequest(username: 'user', password: 'user123');

  test('should be a subclass of login params', () async {
    // Assert
    expect(tLoginRequest, isA<LoginParams>());
  });

  test('should return a JSON map from login request', () async {
    // Arrange
    final result = tLoginRequest.toJson();

    // Act
    final expectedJsonMap = {'username': 'user', 'password': 'user123'};

    // Assert
    expect(result, expectedJsonMap);
  });
}
