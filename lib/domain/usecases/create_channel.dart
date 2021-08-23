import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class CreateChannel extends UseCase<Channel, ChannelParams> {
  final ChannelRepository channelRepository;

  CreateChannel({required this.channelRepository});

  @override
  Future<Either<Failure, Channel>> call(ChannelParams params) async {
    return await channelRepository.createChannel(params.name);
  }
}

class ChannelParams {
  final String name;

  ChannelParams({required this.name});
}
