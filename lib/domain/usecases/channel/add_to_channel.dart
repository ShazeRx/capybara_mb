import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddToChannel extends UseCase<void, AddToChannelParams> {
  final ChannelRepository _channelRepository;

  AddToChannel({required ChannelRepository channelRepository})
      : this._channelRepository = channelRepository;

  @override
  Future<Either<Failure, void>> call(params) async {
    return await _channelRepository.addToChannel(params);
  }
}

class AddToChannelParams extends Equatable {
  final String userId;
  final String channelId;

  AddToChannelParams({required this.userId, required this.channelId});

  @override
  List<Object> get props => [this.userId, this.channelId];
}
