import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import 'message_params.dart';

class SendMessage implements UseCase<List<Message>, MessageParams> {
  late final ChatRepository chatRepository;

  SendMessage({required this.chatRepository});

  @override
  Future<Either<Failure, List<Message>>> call(MessageParams params) {
    return this.chatRepository.sendMessage(params);
  }
}
