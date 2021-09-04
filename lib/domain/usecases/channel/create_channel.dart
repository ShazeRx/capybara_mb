import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateChannel extends UseCase<Channel, CreateChannelParams> {
  final ChannelRepository _channelRepository;

  CreateChannel({required ChannelRepository channelRepository})
      : this._channelRepository = channelRepository;

  @override
  Future<Either<Failure, Channel>> call(CreateChannelParams params) async {
    return await _channelRepository.createChannel(params);
  }
}

class CreateChannelParams extends Equatable {
  final String name;
  final List<int> users;

  CreateChannelParams({required this.name, required this.users});

  @override
  List<Object> get props => [this.name, this.users];
}
