import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:flutter/material.dart';

class NewChannelListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        Icons.add,
        color: theme.iconTheme.color,
      ),
      title: Text(
        'Add channel',
        style: theme.textTheme.bodyText2,
        // softWrap: false,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          RoutePaths.newChannelRoute,
        );
      },
    );
  }
}
