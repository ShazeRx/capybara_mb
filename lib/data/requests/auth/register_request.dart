import 'package:capybara_app/domain/usecases/auth/register_user.dart';

class RegisterRequest extends RegisterParams {
  RegisterRequest({
    required username,
    required email,
    required password,
  }) : super(
          username: username,
          email: email,
          password: password,
        );

  factory RegisterRequest.fromParams(RegisterParams params) {
    return RegisterRequest(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'email': this.email,
      'password': this.password,
    };
  }
}
