import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class UserProfileProvider extends BaseProvider {
  late AuthFacade _authFacade;

  UserProfileProvider({
    required AuthFacade authFacade,
  }) : this._authFacade = authFacade;

  onLogoutPressed() async {
    this.setState(ProviderState.busy);

    final result = await this._authFacade.logoutUser();

    result.fold(
      (failure) => this.showError(failure.message),
      (unit) => this.navigateTo(RoutePaths.loginRoute),
    );

    this.setState(ProviderState.idle);
  }
}
