import 'package:capybara_app/domain/entities/message.dart';

abstract class ChatLocalDataSource {
  Future<List<Message>> fetchLast10Messages();

  Future<void> cacheMessages(List<Message> channels);
}
