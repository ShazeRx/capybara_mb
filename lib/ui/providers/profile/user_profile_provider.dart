import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/domain/usecases/auth/logout_user.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';

class UserProfileProvider extends BaseProvider {
  final LogoutUser _logoutUser;
  final TokenState _tokenState;
  final UserState _userState;

  UserProfileProvider({
    required TokenState tokenState,
    required UserState userState,
    required LogoutUser logoutUser,
  })  : this._tokenState = tokenState,
        this._userState = userState,
        this._logoutUser = logoutUser;

  onLogoutPressed() async {
    this.setState(ProviderState.busy);

    final result = await this._logoutUser(NoParams());

    result.fold(
      (failure) => this.showError(failure.message),
      (unit) => this.navigateTo(RoutePaths.loginRoute),
    );

    if (result.isRight()) {
      this._tokenState.setToken(null);
      this._userState.setUser(null);
    }

    this.setState(ProviderState.idle);
  }
}
