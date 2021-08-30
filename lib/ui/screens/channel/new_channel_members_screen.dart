import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';
import 'package:capybara_app/ui/widgets/channel/new_members/member_list.dart';
import 'package:capybara_app/ui/widgets/home/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewChannelMembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => getIt<NewChannelMembersProvider>(),
      child: Consumer<NewChannelMembersProvider>(
        builder: (_, newChannel, __) => Scaffold(
          appBar: HomeAppBar(
            title: 'New channel members',
          ),
          body: SingleChildScrollView(
            child: MemberList(),
          ),
          floatingActionButton: FloatingActionButton(
            child: SvgPicture.asset(
              SvgIcons.arrowNext,
              color: theme.iconTheme.color,
            ),
            onPressed: () {
              newChannel.onAddChannelMembersClicked();
            },
          ),
        ),
      ),
    );
  }
}
