import 'package:capybara_app/core/constants/failure_messages.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';

class CacheFailure extends Failure {
  CacheFailure() : super(message: FailureMessages.cacheFailure);
}
