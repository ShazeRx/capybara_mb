import 'package:capybara_app/ui/widgets/channel/list/channel_list.dart';
import 'package:capybara_app/ui/widgets/channel/list/new_channel_list_tile.dart';
import 'package:flutter/material.dart';

class ChannelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          ChannelList(),
          NewChannelListTile(),
        ],
      ),
    );
  }
}
