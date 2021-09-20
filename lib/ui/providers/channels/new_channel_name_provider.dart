import 'dart:async';

import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NewChannelNameProvider extends BaseProvider implements Disposable {
  final channelNameController = new TextEditingController();
  final CreateChannel _createChannel;

  NewChannelNameProvider({required CreateChannel createChannel})
      : this._createChannel = createChannel;

  Future<void> onAddChannelClicked(List<int> members) async {
    final channelName = channelNameController.text;
    if (channelName.isEmpty) {
      this.showError('Channel name should not be empty');
      return;
    }
    final response = await this._createChannel(
        this.getChannelParams(channelNameController.text, members));
    response.fold(
      (failure) => this.showError(failure.message),
      (channel) => null,
    );
    this.navigateTo(RoutePaths.homeRoute);
    this.showSuccess('Channel added successfully');
  }

  CreateChannelParams getChannelParams(String channelName, List<int> members) {
    return CreateChannelParams(name: channelName, users: members);
  }

  @override
  FutureOr onDispose() {
    this.channelNameController.dispose();
  }
}
