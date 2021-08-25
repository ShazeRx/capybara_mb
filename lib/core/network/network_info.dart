import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoImpl({
    required InternetConnectionChecker connectionChecker,
  }) : this._connectionChecker = connectionChecker;

  @override
  Future<bool> get isConnected => this._connectionChecker.hasConnection;
}
