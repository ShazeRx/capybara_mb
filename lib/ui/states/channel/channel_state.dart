import 'dart:async';

import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ChannelsState with Disposable {
  BehaviorSubject<List<Channel>?> _channels =
      new BehaviorSubject<List<Channel>?>();

  BehaviorSubject<List<Channel>?> get channels => _channels;

  void setChannels(List<Channel>? channels) {
    this._channels.add(channels);
  }

  @override
  FutureOr onDispose() {
    this._channels.close();
  }
}
