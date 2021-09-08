import 'package:capybara_app/ui/states/channel/channel_state_notifier.dart';
import 'package:capybara_app/ui/widgets/channel/new_members/member_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelStateNotifier>(builder: (_, notifier, __) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: notifier.users.length,
        itemBuilder: (ctx, i) => MemberListTile(
          user: notifier.users[i],
        ),
      );
    });
  }
}
