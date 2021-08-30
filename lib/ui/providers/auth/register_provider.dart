import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class RegisterProvider extends BaseProvider {
  final AuthFacade _authFacade;

  var registerData = {
    'username': '',
    'email': '',
    'password': '',
  };

  RegisterProvider({
    required AuthFacade authFacade,
  }) : this._authFacade = authFacade;

  Future<void> onRegisterSubmitted() async {
    this.setState(ProviderState.busy);

    final result =
        await this._authFacade.registerUser(this.getRegisterParams());

    result.fold(
      (failure) => this.showError(failure.message),
      (user) => {
        this.backToPreviousScreen(),
        //TODO - add file with translations
        this.showSuccess(
            'Successful registration, a confirmation link has been sent to your email address'),
      },
    );

    this.setState(ProviderState.idle);
  }

  RegisterParams getRegisterParams() {
    return RegisterParams(
      username: this.registerData['username']!,
      email: this.registerData['email']!,
      password: this.registerData['password']!,
    );
  }
}
