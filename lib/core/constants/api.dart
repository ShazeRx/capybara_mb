class Api {
  static const baseUrl = 'https://cpbra-be-dev.herokuapp.com';
  static const baseSocketUrl = 'wss://cpbra-be-dev.herokuapp.com';
  static const loginUrl = '/auth/login/';
  static const registerUrl = '/auth/register/';
  static const refreshUrl = '/auth/refresh/';
  static const channelUrl = '/channels/';
  static const usersUrl = '/users/';
  static const socketJoinChannelUrl = '/ws/chat/%i/?token=%s';
}
