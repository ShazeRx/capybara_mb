import 'dart:convert';

import 'package:capybara_app/data/models/channel_model.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final ChannelModel channel = ChannelModel(name: 'somebody');
  test('should be a subclass of Channel entity', () {
    // assert
    expect(channel, isA<Channel>());
  });
  test('should parse to json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('channel.json'));
    //act
    final result = channel.toJson();
    //assert
    expect(result, jsonMap);
  });
  test('should parse to model', () {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('channel.json'));
    //act
    final result = ChannelModel.fromJson(jsonMap);
    //assert
    expect(result, channel);
  });
}
