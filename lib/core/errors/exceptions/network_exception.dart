import 'package:capybara_app/core/constants/exceptions.dart';
import 'package:capybara_app/core/errors/exceptions/base_exception.dart';

class NetworkException extends BaseException {
  NetworkException() : super(message: Exceptions.networkException);
}
