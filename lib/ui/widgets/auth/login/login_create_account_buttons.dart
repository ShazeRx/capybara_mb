import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/helpers/ui/focus_scope_helper.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:flutter/material.dart';

class LoginCreateAccountButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        Text(
          'or... Create account with:',
          style: theme.textTheme.bodyText2,
        ),
        VerticalSpaceHelper.verticalSpaceSmall(context),
        // TODO - implement google and github signin
        // ElevatedButton.icon(
        //   onPressed: () async {
        //     // await this._handleSignIn();
        //   },
        //   icon: Icon(Icons.ac_unit_outlined),
        //   label: Text('Google'),
        // ),
        // VerticalSpaceHelper.verticalSpaceSmall(context),
        // ElevatedButton.icon(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.access_alarm_outlined,
        //   ),
        //   label: Text('Github'),
        // ),
        VerticalSpaceHelper.verticalSpaceSmall(context),
        ElevatedButton.icon(
          onPressed: () {
            FocusScopeHelper.unfocus(context);
            Navigator.of(context).pushNamed(
              RoutePaths.registerRoute,
            );
          },
          icon: Icon(Icons.email),
          label: Text('Email'),
          style: theme.elevatedButtonTheme.style,
        ),
      ],
    );
  }
}
