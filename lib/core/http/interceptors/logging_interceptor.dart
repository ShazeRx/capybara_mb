import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoggingInterceptor extends PrettyDioLogger {
  LoggingInterceptor()
      : super(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true);
}
