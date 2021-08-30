import 'package:capybara_app/core/constants/images.dart';
import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/ui/widgets/channel/list/channel_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChannelListTile extends StatelessWidget {
  final String title;
  final int members;

  ChannelListTile({
    required this.title,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.backgroundColor,
        backgroundImage: AssetImage(Images.channelPlaceholder),
      ),
      title: Text(
        this.title,
        style: theme.textTheme.bodyText2,
      ),
      subtitle: Text(
        this.members.toString() + (this.members == 1 ? ' member' : ' members'),
        style: theme.textTheme.subtitle1,
      ),
      trailing: SvgPicture.asset(
        SvgIcons.arrowNext,
        color: theme.iconTheme.color,
        height: 15,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          RoutePaths.chatRoute,
          arguments: Channel(
            title: this.title,
            members: this.members,
          ),
        );
      },
      selected: true,
    );
  }
}
