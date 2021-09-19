import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:flutter/cupertino.dart';

class TokenStateNotifier with ChangeNotifier {
  final TokenState _tokenState;

  Token? _token;
  Token? get token => this._token;

  TokenStateNotifier({
    required TokenState tokenState,
  }) : this._tokenState = tokenState {
    this._addTokenListener();
  }
  _addTokenListener() {
    this._tokenState.token$.stream.listen((value) {
      this._token = value;
      notifyListeners();
    });
  }
}
