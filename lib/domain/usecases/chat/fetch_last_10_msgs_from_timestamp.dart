import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchLast10MsgsFromTimestamp
    implements UseCase<List<Message>, FetchMsgParams> {
  final ChatRepository chatRepository;

  FetchLast10MsgsFromTimestamp({required this.chatRepository});

  @override
  Future<Either<Failure, List<Message>>> call(FetchMsgParams params) async {
    return await chatRepository
        .fetchLast10MessagesFromTimestamp(params.timestamp);
  }
}

class FetchMsgParams extends Equatable {
  final String timestamp;

  FetchMsgParams({required this.timestamp});

  @override
  List<Object?> get props => [this.timestamp];
}
