import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchUsers extends UseCase<List<User>, NoParams> {
  final ChannelRepository _channelRepository;

  FetchUsers({required ChannelRepository channelRepository})
      : this._channelRepository = channelRepository;

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return this._channelRepository.fetchUsers();
  }
}
