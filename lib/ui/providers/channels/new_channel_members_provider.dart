import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';

class NewChannelMembersProvider extends BaseProvider {
  List<User> _selectedUserTiles = [];

  List<User> get selectedUserTiles => [...this._selectedUserTiles];

  void onUserListTileClicked(User user) {
    this._selectedUserTiles.contains(user)
        ? this._selectedUserTiles.remove(user)
        : this._selectedUserTiles.add(user);

    notifyListeners();
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
