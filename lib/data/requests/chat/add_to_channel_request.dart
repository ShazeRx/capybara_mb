import 'package:capybara_app/domain/usecases/chat/add_to_channel.dart';

class AddToChannelRequest extends AddToChannelParams {
  AddToChannelRequest({required userId, required channelId})
      : super(userId: userId, channelId: channelId);

  factory AddToChannelRequest.fromParams(AddToChannelParams params) {
    return AddToChannelRequest(
        userId: params.userId, channelId: params.channelId);
  }

// Map<String, dynamic> toJson() {
//   return {"name": this.name};
// }
}
