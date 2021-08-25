import 'package:capybara_app/core/errors/failures/failure.dart';

class ServerFailure extends Failure {
  ServerFailure({
    required message,
  }) : super(message: message);
}
