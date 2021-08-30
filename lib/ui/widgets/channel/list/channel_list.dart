import 'package:capybara_app/ui/widgets/channel/list/channel_list_tile.dart';
import 'package:flutter/material.dart';
import 'channel_list_tile.dart';

// Temporarily
class Channel {
  final String title;
  final int members;

  Channel({
    required this.title,
    required this.members,
  });
}

class ChannelList extends StatelessWidget {
  final _channels = [
    Channel(title: 'Channel1', members: 1),
    Channel(title: 'Channel1', members: 20),
    Channel(title: 'Channel2', members: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: this._channels.length,
      itemBuilder: (ctx, i) => ChannelListTile(
        title: this._channels[i].title,
        members: this._channels[i].members,
      ),
    );
  }
}
