import 'package:capybara_app/features/auth/data/models/token_model.dart';

abstract class AuthLocalDataSource {
  /// Gets the cached [TokenModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TokenModel> fetchToken();

  Future<void> cacheToken(TokenModel token);
}
