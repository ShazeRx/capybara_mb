import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:flutter/cupertino.dart';

import 'channel_state.dart';

class ChannelStateNotifier with ChangeNotifier {
  final ChannelsState _channelsState;
  List<Channel> _channels = [];
  List<User> _users = [];

  List<User> get users => _users;

  List<Channel> get channels => _channels;

  ChannelStateNotifier({required ChannelsState channelsState})
      : this._channelsState = channelsState {
    _addChannelListener();
    _addUserListener();
  }

  _addChannelListener() {
    this._channelsState.channels$.stream.listen((value) {
      this._channels = value;
      notifyListeners();
    });
  }

  _addUserListener() {
    this._channelsState.users$.stream.listen((value) {
      this._users = value;
      notifyListeners();
    });
  }
}
