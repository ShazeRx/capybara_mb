import 'dart:convert';

import 'package:capybara_app/data/models/message_model.dart';
import 'package:capybara_app/domain/entities/message.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final MessageModel model =
      MessageModel("21.01.2021", message: 'once', username: 'somebody');
  test('should be subclass of entity', () {
    //Assert
    expect(model, isA<Message>());
  });
  test('should parse to model', () {
    //Arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('message.json'));

    //Act
    final result = MessageModel.fromJson(jsonMap);

    //Assert
    expect(result, model);
  });
  test('should parse to json', () {
    //Arrange
    final jsonModel = model.toJson();

    final Map<String, dynamic> expectedJson =
        json.decode(fixture('message.json'));

    //Assert
    expect(jsonModel, expectedJson);
  });
}
