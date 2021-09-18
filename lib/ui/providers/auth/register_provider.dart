import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/extensions/either_extensions.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';

class RegisterProvider extends BaseProvider {
  final UserState _userState;
  final RegisterUser _registerUser;

  var registerData = {
    'username': '',
    'email': '',
    'password': '',
  };

  RegisterProvider({
    required UserState userState,
    required RegisterUser registerUser,
  })  : this._userState = userState,
        this._registerUser = registerUser;

  Future<void> onRegisterSubmitted() async {
    this.setState(ProviderState.busy);

    final result = await this._registerUser(this.getRegisterParams());

    result.fold(
      (failure) => this.showError(failure.message),
      (user) => {
        this.backToPreviousScreen(),
        //TODO - add file with translations
        this.showSuccess(
            'Successful registration, a confirmation link has been sent to your email address'),
      },
    );

    this._userState.setUser(result.getValueOrNull<User>());

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
