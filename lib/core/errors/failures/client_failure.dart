import 'package:capybara_app/core/errors/failures/failure.dart';

class ClientFailure extends Failure {
  ClientFailure({
    required message,
  }) : super(message: message);
}
