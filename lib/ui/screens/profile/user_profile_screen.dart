import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/ui/providers/profile/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => getIt<UserProfileProvider>(),
      child: Consumer<UserProfileProvider>(
        builder: (_, profile, __) => Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              await profile.onLogoutPressed();
            },
            icon: SvgPicture.asset(
              SvgIcons.logout,
              color: theme.iconTheme.color,
              height: 20,
            ),
            label: Text('Logout'),
            style: theme.elevatedButtonTheme.style,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
