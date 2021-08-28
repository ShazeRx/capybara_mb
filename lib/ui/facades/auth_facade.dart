import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/auth/fetch_token.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:dartz/dartz.dart';
import '../../core/extensions/either_extensions.dart';

class AuthFacade {
  final AuthState _authState;
  final FetchToken _fetchToken;
  final LoginUser _loginUser;
  final RegisterUser _registerUser;

  AuthFacade({
    required AuthState authState,
    required FetchToken fetchToken,
    required LoginUser loginUser,
    required RegisterUser registerUser,
  })  : this._authState = authState,
        this._fetchToken = fetchToken,
        this._loginUser = loginUser,
        this._registerUser = registerUser;

  Future<Either<Failure, Token>> fetchToken() async {
    final result = await this._fetchToken(NoParams());
    this._authState.setToken(result.getValueOrNull<Token>());
    return result;
  }

  Future<Either<Failure, Token>> loginUser(LoginParams params) async {
    final result = await this._loginUser(params);
    this._authState.setToken(result.getValueOrNull<Token>());
    return result;
  }

  Future<Either<Failure, User>> registerUser(RegisterParams params) async {
    final result = await this._registerUser(params);
    this._authState.setUser(result.getValueOrNull<User>());
    return result;
  }
}
