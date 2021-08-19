import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth_remote_data_source.dart';
import 'package:capybara_app/data/repositories/auth_repository_impl.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/fetch_token.dart';
import 'package:capybara_app/domain/usecases/login_user.dart';
import 'package:capybara_app/domain/usecases/register_user.dart';
import 'package:capybara_app/ui/providers/login_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

GetIt getIt = GetIt.instance;

Future<void> registerDependencies() async {
  _registerProviders();
  _registerUseCases();
  _registerRepositories();
  _registerDataSources();
  _registerCoreFeatures();
  await _registerExternalDependencies();
  _registerThirdPartyServices();
}

void _registerProviders() {
  getIt.registerFactory(
    () => LoginProvider(
      loginUser: getIt(),
    ),
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
}

void _registerRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
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
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectionChecker: getIt(),
      ));
}

Future<void> _registerExternalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}


void _registerThirdPartyServices() {
  getIt.registerLazySingleton(() => DialogService());
  getIt.registerLazySingleton(() => SnackbarService());
  getIt.registerLazySingleton(() => NavigationService());
}


