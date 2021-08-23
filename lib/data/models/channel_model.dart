import 'package:capybara_app/domain/entities/channel.dart';

class ChannelModel extends Channel {
  ChannelModel({required String name}) : super(name: name);

  Map<String, dynamic> toJson() {
    return {"name": this.name};
  }

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(name: json["name"]);
  }
}
