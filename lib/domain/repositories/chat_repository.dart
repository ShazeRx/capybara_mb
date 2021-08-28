import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(String body);

  Future<Either<Failure, List<Message>>> fetchLast10Messages();

  Future<Either<Failure, List<Message>>> fetchLast10MessagesFromTimestamp(
      String timestamp);
}
