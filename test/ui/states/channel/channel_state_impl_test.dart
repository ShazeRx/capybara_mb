import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ChannelsStateImpl channelsStateImpl;

  setUp(() {
    channelsStateImpl = ChannelsStateImpl();
  });
  final List<Channel> channels = new List.of([
    Channel(
        name: 'some',
        users: new List.of(
            [User(id: 1, username: 'user', email: 'user@user.com')]))
  ]);
  final users = List.generate(
      4,
          (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  group('set channels', () {
    test('should set channels', () {
      //Arrange
      channelsStateImpl.setChannels(channels);

      //Act
      final result = channelsStateImpl.channels.value;

      //Assert
      expect(result, channels);
    });
  });
  group('set users', () {
    test('should set users', () {
      //Arrange
      channelsStateImpl.setUsers(users);

      //Act
      final result = channelsStateImpl.users.value;

      //Assert
      expect(result, channels);
    });
  });
}
