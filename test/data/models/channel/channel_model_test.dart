import 'dart:convert';

import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/data/models/channel/channel_model.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  const String channelNameFirst = 'somebody';
  const String channelNameSecond = 'once';

  List<ChannelModel> channels = [];
  final users = List.generate(
      4,
      (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  channels.add(ChannelModel(
      name: channelNameFirst, users: users.getRange(0, 2).toList()));
  channels.add(ChannelModel(
      name: channelNameSecond, users: users.getRange(2, 4).toList()));
  final Map<String, dynamic> jsonMap =
      json.decode(fixture(FixturePaths.channelJson));
  test('should be a subclass of Channel entity', () {
    // assert
    //TODO - Need to think about better way to declare fixtures which will be
    // valid with actual code, imo dynamic fixtures in code are better
    expect(channels[0], isA<Channel>());
  });
  test('should parse to json', () async {
    //act
    final result = channels[0].toJson();

    //assert
    expect(result, jsonMap);
  });
  test('should parse to model', () {
    //act
    final result = ChannelModel.fromJson(jsonMap);

    //assert
    expect(result, channels[0]);
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
