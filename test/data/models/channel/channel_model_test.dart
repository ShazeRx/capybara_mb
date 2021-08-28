import 'dart:convert';

import 'package:capybara_app/data/models/channel/channel_model.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  final ChannelModel channel = ChannelModel(name: 'somebody');
  const String channelNameFirst = 'somebody';
  const String channelNameSecond = 'once';

  List<ChannelModel> channels = [];
  channels.add(ChannelModel(name: channelNameFirst));
  channels.add(ChannelModel(name: channelNameSecond));
  final Map<String, dynamic> jsonMap =
      json.decode(fixture(FixturePaths.channelJson));
  test('should be a subclass of Channel entity', () {
    // assert
    expect(channel, isA<Channel>());
  });
  test('should parse to json', () async {
    //act
    final result = channel.toJson();

    //assert
    expect(result, jsonMap);
  });
  test('should parse to model', () {
    //act
    final result = ChannelModel.fromJson(jsonMap);

    //assert
    expect(result, channel);
  });
  test('should parse list to json', () {
    //Arrange
    final jsonList = json.encode(channels);

    //Act
    final result = ChannelModel.fromListToJson(channels);

    //Assert
    expect(result, jsonList);
  });
  test('should parse json to list', () {
    //Arrange
    final List<dynamic> jsonList =
        json.decode(fixture(FixturePaths.channelsJson));

    //Act
    final result = ChannelModel.fromJsonToList(jsonList);

    //Assert
    expect(result, channels);
  });
}
