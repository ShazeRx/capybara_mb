import 'dart:async';

import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

class AuthState with Disposable {
  late BehaviorSubject<Token?> _token = new BehaviorSubject<Token?>();
  late BehaviorSubject<User?> _user = new BehaviorSubject<User?>();

  BehaviorSubject<Token?> get token$ => this._token;
  BehaviorSubject<User?> get user$ => this._user;

  void setToken(Token? token) {
    this._token.add(token);
  }

  void setUser(User? user) {
    this._user.add(user);
  }

  @override
  FutureOr onDispose() {
    this._token.close();
    this._user.close();
  }
}
