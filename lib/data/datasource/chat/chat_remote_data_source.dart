import 'package:capybara_app/core/protocols/websocket/socket_client.dart';
import 'package:capybara_app/data/requests/chat/message_request.dart';
import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';

abstract class ChatRemoteDataSource {
  Future<List<Message>> sendMessage(MessageParams params);

  Future<ChatStream> joinChatSession(int id);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SocketClient _socketClient;

  ChatRemoteDataSourceImpl({required SocketClient socketClient})
      : this._socketClient = socketClient;

  @override
  Future<List<Message>> sendMessage(MessageParams params) {
    params.chatStream.channelConnections.sink
        .add(MessageRequest.fromParams(params));
    return Future.value([Message(null, message: 'some', username: 'body')]);
  }

  @override
  Future<ChatStream> joinChatSession(int id) async {
    final webSocketChannelConnection = this._socketClient.connect(id);
    return ChatStream(channelConnections: webSocketChannelConnection);
  }
}
