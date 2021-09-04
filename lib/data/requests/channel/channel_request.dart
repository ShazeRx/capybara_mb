
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';

class CreateChannelRequest extends CreateChannelParams {
  CreateChannelRequest({required String name, required List<int> users})
      : super(name: name, users: users);

  factory CreateChannelRequest.fromParams(CreateChannelParams params) {
    return CreateChannelRequest(
        name: params.name, users: params.users);
  }

  Map<String, dynamic> toJson() {
    return {"name": this.name, "users": this.users};
  }
}
