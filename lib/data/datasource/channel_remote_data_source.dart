import 'package:capybara_app/data/models/channel_model.dart';

abstract class ChannelRemoteDataSource {
  Future<ChannelModel> createChannel(String name);
  Future<ChannelModel> addToChannel(String channelId, String userId);
  Future<List<ChannelModel>> fetchChannels();
}