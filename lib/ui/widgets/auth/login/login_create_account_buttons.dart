import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/core/helpers/ui/focus_scope_helper.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginCreateAccountButtons extends StatelessWidget {
  final GlobalKey<FormState> _formKey;

  LoginCreateAccountButtons({required formKey}) : this._formKey = formKey;

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
            this._formKey.currentState?.reset();
            Navigator.of(context).pushNamed(
              RoutePaths.registerRoute,
            );
          },
          icon: SvgPicture.asset(
            SvgIcons.email,
            color: theme.iconTheme.color,
          ),
          label: Text('Email'),
          style: theme.elevatedButtonTheme.style,
        ),
      ],
    );
  }
}
