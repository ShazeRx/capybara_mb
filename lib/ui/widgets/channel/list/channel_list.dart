import 'package:capybara_app/ui/providers/channels/channel_provider.dart';
import 'package:capybara_app/ui/states/channel/channel_state_notifier.dart';
import 'package:capybara_app/ui/widgets/channel/list/channel_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'channel_list_tile.dart';

class ChannelList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Consumer<ChannelStateNotifier>(
        builder: (_, channel, __) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: channel.channels.length,
            itemBuilder: (ctx, i) => ChannelListTile(
              title: channel.channels[i].name,
              members: channel.channels[i].users.length,
            ),
          );
        },
      );
  }
}
