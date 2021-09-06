import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:dartz/dartz.dart';

import '../../core/extensions/either_extensions.dart';

class ChannelFacade {
  final AddToChannel _addToChannel;
  final CreateChannel _createChannel;
  final FetchChannels _fetchChannels;
  final ChannelsState _channelsState;

  ChannelFacade(
      {required AddToChannel addToChannel,
      required FetchChannels fetchChannels,
      required CreateChannel createChannel,
      required ChannelsState channelsState})
      : this._addToChannel = addToChannel,
        this._fetchChannels = fetchChannels,
        this._createChannel = createChannel,
        this._channelsState = channelsState;

  Future<Either<Failure, List<Channel>>> fetchChannels() async {
    final result = await this._fetchChannels(NoParams());
    this._channelsState.setChannels(result.getValueOrNull<List<Channel>>());
    return result;
  }

  Future<Either<Failure, Channel>> createChannel(
      CreateChannelParams params) async {
    final result = await this._createChannel(params);
    return result;
  }

  Future<Either<Failure, Unit>> addToChannel(AddToChannelParams params) async {
    final result = await this._addToChannel(params);
    return result;
  }
}
