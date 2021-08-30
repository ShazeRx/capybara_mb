import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewChannelListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      leading: SvgPicture.asset(
        SvgIcons.plus,
        color: theme.iconTheme.color,
        height: 20,
      ),
      title: Text(
        'Add channel',
        style: theme.textTheme.bodyText2,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          RoutePaths.newChannelMembersRoute,
        );
      },
    );
  }
}
