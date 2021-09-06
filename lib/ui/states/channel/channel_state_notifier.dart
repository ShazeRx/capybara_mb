import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:flutter/cupertino.dart';

import 'channel_state.dart';

class ChannelStateNotifier with ChangeNotifier {
  final ChannelsState _channelsState;
  List<Channel> _channels = [];

  List<Channel> get channels => _channels;

  ChannelStateNotifier({required ChannelsState channelsState})
      : this._channelsState = channelsState {
    _addChannelListener();
  }

  _addChannelListener() {
    this._channelsState.channels.listen((value) {
      this._channels = value!;
      notifyListeners();
    });
  }

}
