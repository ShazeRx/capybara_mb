import 'package:capybara_app/domain/usecases/auth/login_user.dart';

class LoginRequest extends LoginParams {
  LoginRequest({
    required username,
    required password,
  }) : super(
          username: username,
          password: password,
        );

  factory LoginRequest.fromParams(LoginParams params) {
    return LoginRequest(
      username: params.username,
      password: params.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }
}
