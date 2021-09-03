import 'dart:convert';

import 'package:capybara_app/domain/usecases/channel/create_channel.dart';

class ChannelRequest extends ChannelParams {
  ChannelRequest({required name, required users})
      : super(name: name, users: users);

  factory ChannelRequest.fromParams(ChannelParams params) {
    return ChannelRequest(name: params.name, users: params.users);
  }

  Map<String, dynamic> toJson() {
    //TODO: need to think about dynamic way to define json values, hardcoded way is difficult to refactor
    final userStringList = this.users.map((e) =>
    {
      "id": e.id,
      "username": e.username,
      "email": e.email
    });
    return {"name": this.name, "users": userStringList};
  }
}
