import 'package:capybara_app/ui/providers/channels/new_channel_name_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

void main() {
  late NewChannelNameProvider provider;

  setUp(() {
    registerManagers();
    provider = NewChannelNameProvider();
  });

  tearDown(() => unregisterManagers());

  group('on add channel clicked', () {
    test('should show error when channel name is empty', () async {
      // Arrange
      provider.channelNameController.text = '';

      // Act
      provider.onAddChannelClicked([]);

      // Assert
      verify(() => mockSnackbarManager.showError(any()));
    });
  });
}
