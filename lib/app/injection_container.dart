import 'package:capybara_app/app/capybara_app_provider.dart';
import 'package:capybara_app/core/managers/navigation_manager.dart';
import 'package:capybara_app/core/managers/snackbar_manager.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/core/protocols/http/http_client.dart';
import 'package:capybara_app/core/protocols/token_utilites.dart';
import 'package:capybara_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:capybara_app/data/datasource/channel/channel_local_data_source.dart';
import 'package:capybara_app/data/datasource/channel/channel_remote_data_source.dart';
import 'package:capybara_app/data/repositories/auth_repository_impl.dart';
import 'package:capybara_app/data/repositories/channel_repository_impl.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/auth/fetch_token.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/domain/usecases/auth/logout_user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_users.dart';
import 'package:capybara_app/ui/providers/channels/channel_provider.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';
import 'package:capybara_app/ui/providers/home/home_provider.dart';
import 'package:capybara_app/ui/providers/auth/login_provider.dart';
import 'package:capybara_app/ui/providers/auth/register_provider.dart';
import 'package:capybara_app/ui/providers/profile/user_profile_provider.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:capybara_app/ui/states/auth/token_state_notifier.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';
import 'package:capybara_app/ui/states/auth/user_state_notifier.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:capybara_app/ui/states/channel/channel_state_notifier.dart';
import 'package:capybara_app/ui/states/user/users_state.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> registerDependencies() async {
  _registerProviders();
  _registerStates();
  _registerUseCases();
  _registerRepositories();
  _registerDataSources();
  _registerCoreFeatures();
  _registerManagers();
  await _registerExternalDependencies();
}

void _registerProviders() {
  getIt.registerFactory(
    () => LoginProvider(
      loginUser: getIt(),
      tokenState: getIt(),
      userState: getIt(),
    ),
  );

  getIt.registerFactory(
    () => RegisterProvider(
      registerUser: getIt(),
      userState: getIt(),
    ),
  );

  getIt.registerFactory(
    () => HomeProvider(),
  );

  getIt.registerFactory(
    () => UserProfileProvider(
      logoutUser: getIt(),
      tokenState: getIt(),
      userState: getIt(),
    ),
  );

  getIt.registerFactory(
    () =>
        NewChannelMembersProvider(fetchUsers: getIt(), usersState: getIt()),
  );

  // getIt.registerFactory(
  //   () => NewChannelNameProvider(
  //     channelFacade: getIt(),
  //   ),
  // );
  getIt.registerFactory(
      () => ChannelProvider(channelsState: getIt(), fetchChannels: getIt()));

  getIt.registerFactory(
    () => CapybaraAppProvider(
      fetchToken: getIt(),
      tokenState: getIt(),
    ),
  );
}

void _registerStates() {
  //Auth
  getIt.registerLazySingleton<TokenState>(
    () => TokenStateImpl(),
  );
  getIt.registerLazySingleton<UserState>(
    () => UserStateImpl(),
  );
  getIt.registerLazySingleton(
    () => TokenStateNotifier(
      tokenState: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => UserStateNotifier(
      userState: getIt(),
    ),
  );

  //Channels
  getIt.registerLazySingleton(
    () => ChannelStateNotifier(
      channelsState: getIt(),
    ),
  );
  getIt.registerLazySingleton<ChannelsState>(
          () => ChannelsStateImpl()
  );

  //Users
  getIt.registerLazySingleton<UsersState>(
          () => UsersStateImpl()
  );
}

void _registerUseCases() {
  //Auth
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

  // //Channel
  getIt.registerLazySingleton(() => AddToChannel(channelRepository: getIt()));
  getIt.registerLazySingleton(() => CreateChannel(channelRepository: getIt()));
  getIt.registerLazySingleton(() => FetchChannels(channelRepository: getIt()));
  getIt.registerLazySingleton(() => FetchUsers(channelRepository: getIt()));
}

void _registerRepositories() {
  //Auth
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
        networkInfo: getIt()),
  );

  //Channel
  getIt.registerLazySingleton<ChannelRepository>(() => ChannelRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt()));
}

void _registerDataSources() {
  //Auth
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

  //Channel
  getIt.registerLazySingleton<ChannelRemoteDataSource>(
      () => ChannelRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<ChannelLocalDataSource>(
    () => ChannelLocalDataSourceImpl(
      sharedPreferences: getIt(),
    ),
  );
}

void _registerCoreFeatures() {
  getIt.registerLazySingleton<TokenUtilities>(
    () => TokenUtilitiesImpl(
      sharedPreferences: getIt(),
    ),
  );

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
    () => SnackbarManagerImpl(),
  );

  getIt.registerLazySingleton<NavigationManager>(
    () => NavigationManagerImpl(),
  );
}

Future<void> _registerExternalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
