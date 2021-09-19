import 'dart:async';

import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

abstract class TokenState implements Disposable {
  BehaviorSubject<Token?> get token$;

  void setToken(Token? token);
}

class TokenStateImpl implements TokenState {
  BehaviorSubject<Token?> _token = new BehaviorSubject<Token?>();

  BehaviorSubject<Token?> get token$ => this._token;

  @override
  void setToken(Token? token) {
    this._token.add(token);
  }

  @override
  FutureOr onDispose() {
    this._token.close();
  }
}
