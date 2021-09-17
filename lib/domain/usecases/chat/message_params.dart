
import 'package:capybara_app/core/constants/websocket_message_types.dart';
import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:equatable/equatable.dart';

abstract class MessageType {
  String get type;
}

class MessageParams extends Equatable {
  final MessageType messageType;
  final String? body;
  final ChatStream chatStream;

  MessageParams(
      {this.body,
        required this.chatStream,
        required this.messageType});

  @override
  List<Object?> get props => [this.body];
}


class FetchLast10MessageType implements MessageType {
  @override
  String get type => WebsocketMessageType.fetchLast10Messages;
}

class SendMessageType implements MessageType {
  @override
  String get type => WebsocketMessageType.newMessage;
}

class FetchLast10MessagesType implements MessageType {
  @override
  String get type => WebsocketMessageType.fetchLast10Messages;
}
