import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message;
  final String username;
  final String? timestamp;

  Message(this.timestamp, {required this.message, required this.username});

  @override
  List<Object?> get props => [this.timestamp, this.message, this.username];
}
