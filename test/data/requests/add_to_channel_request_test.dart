import 'package:capybara_app/data/requests/chat/add_to_channel_request.dart';
import 'package:capybara_app/domain/usecases/chat/add_to_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tAddToChannelRequest = AddToChannelRequest(userId: '1',channelId:'1');

  test('should be a subclass of add to channel params', () async {
    // Assert
    expect(tAddToChannelRequest, isA<AddToChannelParams>());
  });

  test('should return a JSON map from add to channel request', () async {
    // Arrange
    final result = tAddToChannelRequest.toJson();

    // Act
    final expectedJsonMap = {'userId':'1','channelId':'1'};

    // Assert
    expect(result, expectedJsonMap);
  });
}