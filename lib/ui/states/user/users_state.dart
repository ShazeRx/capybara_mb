import 'dart:async';

import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

abstract class UsersState implements Disposable {

  BehaviorSubject<List<User>> get users$;

  void setUsers(List<User> users);
}
class UsersStateImpl implements UsersState {

  BehaviorSubject<List<User>> _users = new BehaviorSubject<List<User>>();


  BehaviorSubject<List<User>> get users$ => _users;
  
  @override
  FutureOr onDispose() {
    this._users.close();
  }

  @override
  void setUsers(List<User> users) {
    this._users.add(users);
  }
}