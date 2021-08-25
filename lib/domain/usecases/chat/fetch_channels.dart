import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchChannels extends UseCase<List<Channel>, NoParams> {
  final ChannelRepository channelRepository;

  FetchChannels({required this.channelRepository});

  @override
  Future<Either<Failure, List<Channel>>> call(NoParams params) async {
    return await channelRepository.fetchChannels();
  }
}
