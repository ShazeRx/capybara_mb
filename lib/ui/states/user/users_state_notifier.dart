import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/states/user/users_state.dart';
import 'package:flutter/cupertino.dart';

class UsersStateNotifier with ChangeNotifier {
  final UsersState _usersState;
  List<User> _users = [];

  List<User> get users => _users;

  UsersStateNotifier({required UsersState usersState})
      : this._usersState = usersState {
    _addUserListener();
  }

  _addUserListener() {
    this._usersState.users$.stream.listen((value) {
      this._users = value;
      notifyListeners();
    });
  }
}
