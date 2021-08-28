import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/ui/widgets/channel/channel_list.dart';
import 'package:flutter/material.dart';

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
        backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
      ),
      title: Text(
        this.title,
        style: theme.textTheme.bodyText2,
      ),
      subtitle: Text(
        '10 members',
        style: theme.textTheme.subtitle1,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: theme.iconTheme.color,
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
