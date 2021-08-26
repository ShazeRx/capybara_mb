import 'package:capybara_app/domain/entities/message.dart';

abstract class ChatRemoteDataSource{
  Future<void> sendMessage(String message);
  Future<List<Message>> fetchLast10Messages();
  Future<List<Message>> fetchLast10MessagesFromTimestamp(String timestamp);
}