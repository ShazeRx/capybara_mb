import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class LoginProvider extends BaseProvider {
  void onLoginPressed() async {
    this.setState(ProviderState.busy);

    // await login user

    this.setState(ProviderState.idle);
  }
}
