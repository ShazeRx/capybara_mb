import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class CapybaraAppProvider extends BaseProvider {
  final AuthFacade _authFacade;

  CapybaraAppProvider({
    required AuthFacade authFacade,
  }) : this._authFacade = authFacade {
    this.fetchToken();
  }

  Future<void> fetchToken() async {
    this.setState(ProviderState.busy);
    final _ = await this._authFacade.fetchToken();
    this.setState(ProviderState.idle);
  }
}
