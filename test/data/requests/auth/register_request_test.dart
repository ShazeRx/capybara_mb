import 'package:capybara_app/data/requests/auth/register_request.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tRegisterRequest = RegisterRequest(
    username: 'user',
    email: 'user@user.com',
    password: 'user123',
  );

  test('should be a subclass of register params', () async {
    // Assert
    expect(tRegisterRequest, isA<RegisterParams>());
  });

  test('should return a JSON map from register request', () async {
    // Arrange
    final result = tRegisterRequest.toJson();

    // Act
    final expectedJsonMap = {
      'username': 'user',
      'email': 'user@user.com',
      'password': 'user123',
    };

    // Assert
    expect(result, expectedJsonMap);
  });
}
