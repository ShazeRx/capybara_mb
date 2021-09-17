import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';

abstract class ChatRemoteDataSource {
  Future<List<Message>> sendMessage(MessageParams params);

  Future<ChatStream> joinChatSession(int id);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {


  @override
  Future<List<Message>> sendMessage(MessageParams params) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<ChatStream> joinChatSession(int id) {
    // TODO: implement joinChatSession
    throw UnimplementedError();
  }
}
