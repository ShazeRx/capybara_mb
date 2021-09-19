import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';
import 'package:flutter/cupertino.dart';

class UserStateNotifier with ChangeNotifier {
  final UserState _userState;

  User? _user;
  User? get user => this._user;

  UserStateNotifier({
    required UserState userState,
  }) : this._userState = userState {
    this._addUserListener();
  }

  _addUserListener() {
    this._userState.user$.stream.listen((value) {
      this._user = value;
      notifyListeners();
    });
  }
}
