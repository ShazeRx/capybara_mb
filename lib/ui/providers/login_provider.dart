import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class LoginProvider extends BaseProvider {
  final AuthFacade _authFacade;

  var loginData = {
    'username': '',
    'password': '',
  };

  LoginProvider({
    required AuthFacade authFacade,
  }) : _authFacade = authFacade;

  Future<void> onLoginSubmitted() async {
    this.setState(ProviderState.busy);

    final result = await this._authFacade.loginUser(this.getLoginParams());

    result.fold(
      (failure) => this.showError(failure),
      (token) => this.navigationService.navigateTo(''),
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
