import 'package:capybara_app/core/constants/failure_messages.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';

class FailureMessagesHelper {
  static final messages = {
    CacheFailure: FailureMessages.cacheFailure,
    ServerFailure: FailureMessages.serverFailure
  };

  static String getMessage(Failure failure) {
    return messages[failure.runtimeType]!;
  }
}
