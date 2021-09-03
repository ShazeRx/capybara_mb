import 'package:capybara_app/data/requests/channel/channel_request.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userList = [User(id: 1, username: 'some', email: 'some@body.pl')];
  final tChannelRequest = ChannelRequest(name: 'some',users: userList);

  test('should be a subclass of channel params', () async {
    // Assert
    expect(tChannelRequest, isA<ChannelParams>());
  });

  test('should return a JSON map from channel request', () async {
    // Arrange
    final result = tChannelRequest.toJson();

    // Act
    final expectedJsonMap = {'name': 'some','users':[{'id':1,'username':'some','email':'some@body.pl'}]};

    // Assert
    expect(result, expectedJsonMap);
  });
}
