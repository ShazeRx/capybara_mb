import 'package:equatable/equatable.dart';

class BaseException extends Equatable implements Exception {
  final String message;

  const BaseException({required this.message});

  @override
  List<Object> get props => [this.message];
}
