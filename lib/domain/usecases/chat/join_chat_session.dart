import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class JoinChatSession implements UseCase<ChatStream, JoinChannelSessionParams> {
  late final ChatRepository _chatRepository;

  JoinChatSession({required ChatRepository chatRepository})
      :this._chatRepository=chatRepository;

  @override
  Future<Either<Failure, ChatStream>> call(JoinChannelSessionParams params) {
    return this._chatRepository.joinChatSession(params);
  }
}

class JoinChannelSessionParams extends Equatable {
  final int channelId;

  JoinChannelSessionParams({required this.channelId});

  @override
  List<Object?> get props => [this.channelId];
}
