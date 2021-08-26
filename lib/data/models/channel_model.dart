import 'dart:convert';

import 'package:capybara_app/domain/entities/channel.dart';

class ChannelModel extends Channel {
  ChannelModel({required String name}) : super(name: name);

  Map<String, dynamic> toJson() {
    return {"name": this.name};
  }

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(name: json["name"]);
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
