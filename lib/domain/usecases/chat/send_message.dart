import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendMessage implements UseCase<void, MessageParams> {
  late final ChatRepository chatRepository;

  SendMessage({required this.chatRepository});

  @override
  Future<Either<Failure, void>> call(MessageParams params) {
    return this.chatRepository.sendMessage(params.body);
  }
}

class MessageParams extends Equatable {
  final String body;

  MessageParams({required this.body});

  @override
  List<Object?> get props => [this.body];
}
