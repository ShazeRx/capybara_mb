import 'package:capybara_app/features/auth/data/models/token_model.dart';
import 'package:capybara_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the http://? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TokenModel> loginUser(String username, String password);

  /// Calls the http://? endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> registerUser(
    String username,
    String email,
    String password,
  );
}

 

