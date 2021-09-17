import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/usecases/chat/join_chat_session.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Message>>> sendMessage(MessageParams params);

  Future<Either<Failure, List<Message>>> fetchLast10Messages(MessageParams params);

  Future<Either<Failure, List<Message>>> fetchLast10MessagesFromTimestamp(
      MessageParams params);

  Future<Either<Failure, ChatStream>> joinChatSession(
      JoinChannelSessionParams params);
}
