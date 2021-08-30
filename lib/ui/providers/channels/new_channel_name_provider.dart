import 'dart:async';

import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NewChannelNameProvider extends BaseProvider implements Disposable {
  final channelNameController = new TextEditingController();

  void onAddChannelClicked(List<User> members) {
    if (channelNameController.text.isEmpty) {
      this.showError('Channel name should not be empty');
      return;
    }

    // TODO

    // Temporarily
    this.navigateTo(RoutePaths.homeRoute);
  }

  @override
  FutureOr onDispose() {
    this.channelNameController.dispose();
  }
}
