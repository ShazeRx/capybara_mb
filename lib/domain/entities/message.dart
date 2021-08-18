import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String message;
  final String username;
  final String channel;
  final String timestamp;

  Message(
      {required this.channel,
      required this.timestamp,
      required this.message,
      required this.username});

  @override
  List<Object?> get props =>
      [this.channel, this.timestamp, this.message, this.username];
}
