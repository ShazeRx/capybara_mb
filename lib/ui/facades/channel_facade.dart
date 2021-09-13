import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_users.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:dartz/dartz.dart';

import '../../core/extensions/either_extensions.dart';

class ChannelFacade {
  final AddToChannel _addToChannel;
  final CreateChannel _createChannel;
  final FetchChannels _fetchChannels;
  final FetchUsers _fetchUsers;
  final ChannelsState _channelsState;

  ChannelFacade({
    required AddToChannel addToChannel,
    required FetchChannels fetchChannels,
    required CreateChannel createChannel,
    required ChannelsState channelsState,
    required FetchUsers fetchUsers,
  })  : this._addToChannel = addToChannel,
        this._fetchChannels = fetchChannels,
        this._createChannel = createChannel,
        this._channelsState = channelsState,
        this._fetchUsers = fetchUsers;

  Future<Either<Failure, List<Channel>>> fetchChannels() async {
    final result = await this._fetchChannels(NoParams());
    this._channelsState.setChannels(result.getListValuesOrEmptyList<Channel>());
    return result;
  }

  Future<Either<Failure, Channel>> createChannel(
      CreateChannelParams params) async {
    return await this._createChannel(params);
  }

  Future<Either<Failure, Unit>> addToChannel(AddToChannelParams params) async {
    return await this._addToChannel(params);
  }

  Future<Either<Failure, List<User>>> fetchUsers() async {
    final result = await this._fetchUsers(NoParams());
    this._channelsState.setUsers(result.getListValuesOrEmptyList<User>());
    return result;
  }
}
