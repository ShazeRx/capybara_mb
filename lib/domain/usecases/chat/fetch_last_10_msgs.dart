import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchLast10Msgs implements UseCase<List<Message>, NoParams> {
  final ChatRepository chatRepository;

  FetchLast10Msgs({required this.chatRepository});

  @override
  Future<Either<Failure, List<Message>>> call(NoParams params) async {
    return await chatRepository.fetchLast10Messages();
  }
}
