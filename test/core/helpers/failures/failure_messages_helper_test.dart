import 'package:capybara_app/core/constants/failure_messages.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/helpers/failures/failure_messages_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return valid message for cache failure', () {
    // Arrange
    final failure = CacheFailure();

    // Act 
    final result = FailureMessagesHelper.getMessage(failure);

    // Assert 
    expect(result, FailureMessages.cacheFailure);
  });

  test('should return valid message for server failure', () {
    // Arrange
    final failure = ServerFailure();

    // Act 
    final result = FailureMessagesHelper.getMessage(failure);

    // Assert 
    expect(result, FailureMessages.serverFailure);
  });
}