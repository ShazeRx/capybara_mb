

import 'package:capybara_app/core/providers/base_provider.dart';
import 'package:capybara_app/core/utils/enums/provider_state.dart';

class LoginProvider extends BaseProvider  {
  
  void onLoginPressed() async {
    this.setState(ProviderState.busy);

    // await login user

    this.setState(ProviderState.idle);
  }
}