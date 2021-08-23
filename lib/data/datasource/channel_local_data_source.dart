import 'package:capybara_app/data/models/channel_model.dart';

abstract class ChannelLocalDataSource {
  Future<List<ChannelModel>> fetchChannels();

  Future<void> cacheChannels(List<ChannelModel> channels);
}
