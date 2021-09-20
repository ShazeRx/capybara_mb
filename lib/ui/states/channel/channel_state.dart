import 'dart:async';

import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

abstract class ChannelsState implements Disposable {
  BehaviorSubject<List<Channel>> get channels$;

  void setChannels(List<Channel> channels);

}

class ChannelsStateImpl implements ChannelsState {
  BehaviorSubject<List<Channel>> _channels =
      new BehaviorSubject<List<Channel>>();
  BehaviorSubject<List<User>> _users = new BehaviorSubject<List<User>>();

  BehaviorSubject<List<Channel>> get channels$ => _channels;

  BehaviorSubject<List<User>> get users$ => _users;

  void setChannels(List<Channel> channels) {
    this._channels.add(channels);
  }

  @override
  FutureOr onDispose() {
    this._channels.close();
    this._users.close();
  }

}
