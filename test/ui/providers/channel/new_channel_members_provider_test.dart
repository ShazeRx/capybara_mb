import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

void main() {
  late NewChannelMembersProvider provider;

  setUp(() {
    registerThirdPartyServices();
    provider = NewChannelMembersProvider();
  });

  tearDown(() => unregisterThirdPartyServices());

  final tUser = User(id: 1, username: 'user', email: 'user@user.com');

  group('on user list tile clicked', () {
    test(
        'should add user to selected user tiles if user not exists in the list',
        () async {
      // Act
      provider.onUserListTileClicked(tUser);
      final result = provider.selectedUserTiles;

      // Verify
      expect(result, equals([tUser]));
    });

    test(
        'should remove user from selected user tiles if user exists in the list',
        () async {
      // Arrange
      provider.onUserListTileClicked(tUser);

      // Act
      provider.onUserListTileClicked(tUser);
      final result = provider.selectedUserTiles;

      // Assert
      expect(result, equals([]));
    });
  });

  group('on add channel members clicked', () {
    test('should show an error when no members are selected', () {
      // Act
      provider.onAddChannelMembersClicked();

      // Assert
      verify(() => mockSnackbarService.showSnackbar(
          message: 'You must select at least one member'));
    });

    test(
        'should navigate to new channel name screen with selected members as arguments when at least one member is selected',
        () {
      // Arrange
      provider.onUserListTileClicked(tUser);

      // Act
      provider.onAddChannelMembersClicked();

      // Assert
      verify(() => mockNavigationService
          .navigateTo(RoutePaths.newChannelNameRoute, arguments: [tUser]));
    });
  });
}
