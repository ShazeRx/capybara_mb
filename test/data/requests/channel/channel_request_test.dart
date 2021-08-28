import 'package:capybara_app/data/requests/channel/channel_request.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tChannelRequest = ChannelRequest(name: 'some');

  test('should be a subclass of channel params', () async {
    // Assert
    expect(tChannelRequest, isA<ChannelParams>());
  });

  test('should return a JSON map from channel request', () async {
    // Arrange
    final result = tChannelRequest.toJson();

    // Act
    final expectedJsonMap = {'name': 'some'};

    // Assert
    expect(result, expectedJsonMap);
  });
}
