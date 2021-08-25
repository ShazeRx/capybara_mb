import 'package:capybara_app/core/constants/exceptions.dart';
import 'package:capybara_app/core/errors/exceptions/base_exception.dart';

class CacheException extends BaseException {
  CacheException() : super(message: Exceptions.cacheException);
}
