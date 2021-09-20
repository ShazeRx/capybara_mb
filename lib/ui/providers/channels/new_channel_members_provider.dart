import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/extensions/either_extensions.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_users.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/providers/base_provider.dart';
import 'package:capybara_app/ui/states/user/users_state.dart';

class NewChannelMembersProvider extends BaseProvider {
  List<int> _selectedUserTiles = [];
  final FetchUsers _fetchUsers;
  final UsersState _usersState;

  NewChannelMembersProvider(
      {required FetchUsers fetchUsers, required UsersState usersState})
      : this._fetchUsers = fetchUsers,
        this._usersState = usersState {
    this.fetchUsers();
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
    final result = await this._fetchUsers(NoParams());
    this._usersState.setUsers(result.getListValuesOrEmptyList<User>());
    this.setState(ProviderState.idle);
    result.fold(
        (failure) =>
            this.showError("Failed fetching users"),
            (users) => null);
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
