import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/facades/channel_facade.dart';

import '../base_provider.dart';

class ChannelProvider extends BaseProvider {
  final ChannelFacade _channelFacade;

  ChannelProvider({required ChannelFacade channelFacade})
      : this._channelFacade = channelFacade {
    this.setState(ProviderState.busy);
    fetchChannels();
  }

  fetchChannels() async {
    this.setState(ProviderState.busy);
    final result = await this._channelFacade.fetchChannels();
    result.fold((failure) => this.showError("Failed to fetch channels"),
            (channels) => null);
    this.setState(ProviderState.idle);
  }
}
