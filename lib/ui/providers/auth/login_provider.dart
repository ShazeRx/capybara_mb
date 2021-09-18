import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/extensions/either_extensions.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';

class LoginProvider extends BaseProvider {
  final TokenState _tokenState;
  final LoginUser _loginUser;

  var loginData = {
    'username': '',
    'password': '',
  };

  LoginProvider({
    required TokenState tokenState,
    required LoginUser loginUser,
  })  : this._tokenState = tokenState,
        this._loginUser = loginUser;

  Future<void> onLoginSubmitted() async {
    this.setState(ProviderState.busy);

    final result = await this._loginUser(this.getLoginParams());

    result.fold(
      (failure) => this.showError(failure.message),
      (token) => this.navigateTo(RoutePaths.homeRoute),
    );

    this._tokenState.setToken(result.getValueOrNull<Token>());

    this.setState(ProviderState.idle);
  }

  LoginParams getLoginParams() {
    return LoginParams(
      username: this.loginData['username']!,
      password: this.loginData['password']!,
    );
  }
}
