
import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/helpers/ui/focus_scope_helper.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginCreateAccountButtons extends StatelessWidget {
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

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
        ElevatedButton.icon(
          onPressed: () {
            // this._handleSignIn();
          },
          icon: Icon(Icons.ac_unit_outlined),
          label: Text('Google'),
        ),
        VerticalSpaceHelper.verticalSpaceSmall(context),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.access_alarm_outlined,
          ),
          label: Text('Github'),
        ),
        VerticalSpaceHelper.verticalSpaceSmall(context),
        ElevatedButton.icon(
          onPressed: () {
            FocusScopeHelper.unfocus(context);
            Navigator.of(context).pushNamed(
              RoutePaths.registerRoute,
            );
          },
          icon: Icon(Icons.ac_unit_outlined),
          label: Text('Email'),
          style: theme.elevatedButtonTheme.style,
        ),
      ],
    );
  }
}
