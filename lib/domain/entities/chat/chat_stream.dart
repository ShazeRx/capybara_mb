import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatStream extends Equatable {
  final WebSocketChannel streamChannel;

  ChatStream({required this.streamChannel});

  @override
  List<Object?> get props => [this.streamChannel];
}
