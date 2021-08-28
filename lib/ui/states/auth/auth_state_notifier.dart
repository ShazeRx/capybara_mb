import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:flutter/cupertino.dart';

class AuthStateNotifier with ChangeNotifier {
  final AuthState _authState;

  Token? _token;
  User? _user;

  Token? get token => this._token;
  User? get user => this._user;

  AuthStateNotifier({
    required AuthState authState,
  }) : this._authState = authState {
    this._addTokenListener();
    this._addUserListener();
  }

  _addTokenListener() {
    this._authState.token$.stream.listen((value) {
      this._token = value;
      notifyListeners();
    });
  }

  _addUserListener() {
    this._authState.user$.stream.listen((value) {
      this._user = value;
      notifyListeners();
    });
  }
}
