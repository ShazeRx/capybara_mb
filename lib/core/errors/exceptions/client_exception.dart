import 'package:capybara_app/core/errors/exceptions/base_exception.dart';

class ClientException extends BaseException {
  ClientException({
    required message,
  }) : super(message: message);
}
