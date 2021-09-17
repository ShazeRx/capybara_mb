import 'package:capybara_app/domain/entities/chat/message.dart';

abstract class ChatLocalDataSource {
  Future<List<Message>> fetchLast10Messages();
  Future<void> cacheMessage(Message message);

  Future<void> cacheMessages(List<Message> channels);
}
