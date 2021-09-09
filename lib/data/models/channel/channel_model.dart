import 'dart:convert';

import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';

class ChannelModel extends Channel {
  ChannelModel({required String name, required List<User> users})
      : super(name: name, users: users);

  Map<String, dynamic> toJson() {
    final usersJsonList =
        this.users.map((e) => UserModel.fromUserEntity(e).toJson()).toList();

    return {'name': this.name, 'users_list': usersJsonList};
  }

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    final usersModelList =
        (json['users_list'] as List).map((e) => UserModel.fromJson(e)).toList();
    return ChannelModel(name: json["name"], users: usersModelList);
  }

  static List<ChannelModel> fromJsonToList(List<dynamic> json) {
    List<ChannelModel> channelList = [];
    json.forEach((element) {
      channelList.add(ChannelModel.fromJson(element));
    });
    return channelList;
  }

  static String fromListToJson(List<ChannelModel> channels) {
    return json.encode(channels);
  }
}
