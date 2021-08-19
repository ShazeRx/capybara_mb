import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/usecases/login_user.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class LoginProvider extends BaseProvider {
  late Token _token;
  final LoginUser _loginUser;

  var loginData = {
    'username': '',
    'password': '',
  };

  Token get token => _token;

  void setToken(Token token) {
    this._token = token;
    notifyListeners();
  }

  LoginProvider({
    required LoginUser loginUser,
  }) : _loginUser = loginUser;

  Future<void> onLoginSubmitted() async {
    this.setState(ProviderState.busy);

    final result = await this._loginUser(this.getLoginParams());

    result.fold(
      (failure) => this.showError(failure),
      (token) => this.setToken(token),
    );

    this.setState(ProviderState.idle);
  }

  LoginParams getLoginParams() {
    return LoginParams(
      username: this.loginData['username']!,
      password: this.loginData['password']!,
    );
  }
}
