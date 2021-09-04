import 'package:capybara_app/core/constants/images.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MemberListTile extends StatelessWidget {
  final User user;

  MemberListTile({required this.user});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<NewChannelMembersProvider>(
      builder: (_, newChannel, __) => ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.backgroundColor,
          backgroundImage: AssetImage(Images.userPlaceholder),
          radius: 15,
        ),
        title: Text(
          this.user.username,
          style: theme.textTheme.bodyText2,
        ),
        trailing: SvgPicture.asset(
          newChannel.selectedUserTiles.contains(user)
              ? SvgIcons.check
              : SvgIcons.plus,
          color: theme.iconTheme.color,
          height: 15,
        ),
        onTap: () {
          newChannel.onUserListTileClicked(user.id);
        },
        selected: newChannel.selectedUserTiles.contains(user.id),
        selectedTileColor: theme.accentColor,
      ),
    );
  }
}
