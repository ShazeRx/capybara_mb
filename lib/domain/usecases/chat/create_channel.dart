import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateChannel extends UseCase<Channel, ChannelParams> {
  final ChannelRepository _channelRepository;

  CreateChannel({required ChannelRepository channelRepository})
      : this._channelRepository = channelRepository;

  @override
  Future<Either<Failure, Channel>> call(ChannelParams params) async {
    return await _channelRepository.createChannel(params);
  }
}

class ChannelParams extends Equatable {
  final String name;

  ChannelParams({required this.name});

  @override
  List<Object> get props => [this.name];
}
