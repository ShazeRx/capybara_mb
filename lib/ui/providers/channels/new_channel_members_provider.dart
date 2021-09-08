import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/facades/channel_facade.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class NewChannelMembersProvider extends BaseProvider {
  List<int> _selectedUserTiles = [];
  final ChannelFacade _channelFacade;

  NewChannelMembersProvider({required ChannelFacade channelFacade})
      : this._channelFacade = channelFacade {
    fetchUsers();
  }

  List<int> get selectedUserTiles => [...this._selectedUserTiles];

  void onUserListTileClicked(int userId) {
    this._selectedUserTiles.contains(userId)
        ? this._selectedUserTiles.remove(userId)
        : this._selectedUserTiles.add(userId);
    notifyListeners();
  }

  fetchUsers() async {
    this.setState(ProviderState.busy);
    final result = await this._channelFacade.fetchUsers();
    this.setState(ProviderState.idle);
    result.fold(
        (failure) => this.showError("Failed fetching users"), (users) => null);
  }

  void onAddChannelMembersClicked() {
    if (this._selectedUserTiles.length == 0) {
      // TODO - add file with translations
      this.showError('You must select at least one member');
      return;
    }

    this.pushRouteOnStack(
      RoutePaths.newChannelNameRoute,
      this._selectedUserTiles,
    );
  }
}
