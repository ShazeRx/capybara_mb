import 'package:capybara_app/core/http/http_client.dart';
import 'package:capybara_app/core/managers/navigation_manager.dart';
import 'package:capybara_app/core/managers/snackbar_manager.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:capybara_app/data/repositories/auth_repository_impl.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/auth/fetch_token.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/domain/usecases/auth/logout_user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_name_provider.dart';
import 'package:capybara_app/ui/providers/home/home_provider.dart';
import 'package:capybara_app/ui/providers/auth/login_provider.dart';
import 'package:capybara_app/ui/providers/auth/register_provider.dart';
import 'package:capybara_app/ui/providers/profile/user_profile_provider.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:capybara_app/ui/states/auth/auth_state_notifier.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt getIt = GetIt.instance;

Future<void> registerDependencies() async {
  _registerProviders();
  _registerFacades();
  _registerStates();
  _registerUseCases();
  _registerRepositories();
  _registerDataSources();
  _registerCoreFeatures();
  _registerManagers();
  await _registerExternalDependencies();
  _registerThirdPartyServices();
}

void _registerProviders() {
  getIt.registerFactory(
    () => LoginProvider(
      authFacade: getIt(),
    ),
  );

  getIt.registerFactory(
    () => RegisterProvider(
      authFacade: getIt(),
    ),
  );

  getIt.registerFactory(
    () => HomeProvider(),
  );

  getIt.registerFactory(
    () => UserProfileProvider(
      authFacade: getIt(),
    ),
  );

  getIt.registerFactory(
    () => NewChannelMembersProvider(),
  );

  getIt.registerFactory(
    () => NewChannelNameProvider(),
  );
}

void _registerFacades() {
  getIt.registerLazySingleton(
    () => AuthFacade(
      authState: getIt(),
      fetchToken: getIt(),
      loginUser: getIt(),
      registerUser: getIt(),
      logoutUser: getIt(),
    ),
  );
}

void _registerStates() {
  getIt.registerLazySingleton(
    () => AuthStateNotifier(
      authState: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => AuthState(),
  );
}

void _registerUseCases() {
  getIt.registerLazySingleton(
    () => LoginUser(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => RegisterUser(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => FetchToken(
      authRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => LogoutUser(
      authRepository: getIt(),
    ),
  );
}

void _registerRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
        networkInfo: getIt()),
  );
}

void _registerDataSources() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: getIt(),
    ),
  );
}

void _registerCoreFeatures() {
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<HttpClient>(
    () => HttpClientImpl(
      dio: getIt(),
    ),
  );
}

void _registerManagers() {
  getIt.registerLazySingleton<SnackbarManager>(
    () => SnackbarManagerImpl(
      snackbarService: getIt(),
    ),
  );

  getIt.registerLazySingleton<NavigationManager>(
    () => NavigationManagerImpl(
      navigationService: getIt(),
    ),
  );
}

Future<void> _registerExternalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}

void _registerThirdPartyServices() {
  getIt.registerLazySingleton(() => DialogService());
  getIt.registerLazySingleton(() => SnackbarService());
  getIt.registerLazySingleton(() => NavigationService());
}
