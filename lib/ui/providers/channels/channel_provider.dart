import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/extensions/either_extensions.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import '../base_provider.dart';

class ChannelProvider extends BaseProvider {
  final FetchChannels _fetchChannels;
  final ChannelsState _channelsState;

  ChannelProvider({
    required FetchChannels fetchChannels,
    required ChannelsState channelsState,
  })  : this._fetchChannels = fetchChannels,
        this._channelsState = channelsState {
    this.setState(ProviderState.busy);
    this.fetchChannels();
  }

  fetchChannels() async {
    this.setState(ProviderState.busy);
    final result = await this._fetchChannels(NoParams());
    this._channelsState.setChannels(result.getListValuesOrEmptyList<Channel>());
    result.fold((failure) => this.showError("Failed to fetch channels"),
        (channels) => null);
    this.setState(ProviderState.idle);
  }
}
