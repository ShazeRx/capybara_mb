import 'package:capybara_app/core/errors/exceptions/base_exception.dart';

class ServerException extends BaseException {
  ServerException({
    required message,
  }) : super(message: message);
}
