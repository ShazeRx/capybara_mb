import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/extensions/either_extensions.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/usecases/auth/fetch_token.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';

class CapybaraAppProvider extends BaseProvider {
  final FetchToken _fetchToken;
  final TokenState _tokenState;

  CapybaraAppProvider({
    required FetchToken fetchToken,
    required TokenState tokenState,
  })  : this._fetchToken = fetchToken,
        this._tokenState = tokenState {
    this.fetchToken();
  }

  Future<void> fetchToken() async {
    this.setState(ProviderState.busy);
    final result = await this._fetchToken(NoParams());
    this._tokenState.setToken(result.getValueOrNull<Token>());
    this.setState(ProviderState.idle);
  }
}
