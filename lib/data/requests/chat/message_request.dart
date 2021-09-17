import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';

class MessageRequest extends MessageParams {
  MessageRequest(
      {required MessageType messageType,
      String? body,
      required ChatStream chatStream})
      : super(messageType: messageType, body: body, chatStream: chatStream);

  factory MessageRequest.fromParams(MessageParams params) {
    return MessageRequest(
        messageType: params.messageType,
        chatStream: params.chatStream,
        body: params.body);
  }

  Map<String, dynamic> toJson() {
    return {"type": this.messageType.type, "body": this.body};
  }
}
