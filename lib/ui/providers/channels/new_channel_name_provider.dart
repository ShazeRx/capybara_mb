import 'dart:async';

import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/ui/facades/channel_facade.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NewChannelNameProvider extends BaseProvider implements Disposable {
  final channelNameController = new TextEditingController();
  final ChannelFacade _channelFacade;

  NewChannelNameProvider({required ChannelFacade channelFacade})
      : this._channelFacade = channelFacade;

  Future<void> onAddChannelClicked(List<User> members) async {
    final channelName = channelNameController.text;
    if (channelName.isEmpty) {
      this.showError('Channel name should not be empty');
      return;
    }
    final response = await this._channelFacade.createChannel(
        this.getChannelParams(channelNameController.text, members));
    response.fold(
      (failure) => this.showError(failure.message),
      (channel) => null,
    );
    this.navigateTo(RoutePaths.homeRoute);
  }

  ChannelParams getChannelParams(String channelName, List<User> members) {
    return ChannelParams(name: channelName, users: members);
  }

  @override
  FutureOr onDispose() {
    this.channelNameController.dispose();
  }
}
