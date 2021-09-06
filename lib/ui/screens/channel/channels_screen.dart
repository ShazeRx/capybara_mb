import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/ui/providers/channels/channel_provider.dart';
import 'package:capybara_app/ui/states/channel/channel_state_notifier.dart';
import 'package:capybara_app/ui/widgets/channel/list/channel_list.dart';
import 'package:capybara_app/ui/widgets/channel/list/new_channel_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChannelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<ChannelStateNotifier>()),
        ChangeNotifierProvider.value(value: getIt<ChannelProvider>()),
      ],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            ChannelList(),
            NewChannelListTile(),
          ],
        ),
      ),
    );
  }
}
