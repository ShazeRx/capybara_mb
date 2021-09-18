import 'dart:async';

import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

abstract class UserState implements Disposable {
  BehaviorSubject<User?> get user$;

  void setUser(User? user);
}

class UserStateImpl implements UserState {
  BehaviorSubject<User?> _user = new BehaviorSubject<User?>();

  @override
  BehaviorSubject<User?> get user$ => this._user;

  @override
  void setUser(User? user) {
    this._user.add(user);
  }

  @override
  FutureOr onDispose() {
    this._user.close();
  }
}
