import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/ui/providers/channels/channel_provider.dart';
import 'package:capybara_app/ui/states/channel/channel_state_notifier.dart';
import 'package:capybara_app/ui/widgets/channel/list/channel_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'channel_list_tile.dart';

class ChannelList extends StatefulWidget {
  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  @override
  void initState() {
    getIt<ChannelProvider>().fetchChannels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelProvider>(builder: (_, channelProvider, __) {
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
    });
  }
}
