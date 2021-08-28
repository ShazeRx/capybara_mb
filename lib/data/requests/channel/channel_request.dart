import 'package:capybara_app/domain/usecases/channel/create_channel.dart';

class ChannelRequest extends ChannelParams {
  ChannelRequest({required name}) : super(name: name);

  factory ChannelRequest.fromParams(ChannelParams params) {
    return ChannelRequest(name: params.name);
  }

  Map<String, dynamic> toJson() {
    return {"name": this.name};
  }
}
