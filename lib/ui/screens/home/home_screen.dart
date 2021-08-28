import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/ui/providers/home/home_provider.dart';
import 'package:capybara_app/ui/screens/channel/channels_screen.dart';
import 'package:capybara_app/ui/screens/profile/user_profile_screen.dart';
import 'package:capybara_app/ui/widgets/chat/home_app_bar.dart';
import 'package:capybara_app/ui/widgets/chat/home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<HomeProvider>(),
      child: Consumer<HomeProvider>(
        builder: (_, home, __) => Scaffold(
          appBar: HomeAppBar(
            title: home.appBarTitle,
          ),
          body: PageView(
            controller: home.pageController,
            onPageChanged: (index) => home.onPageChanged(index),
            children: <Widget>[
              ChannelsScreen(),
              UserProfileScreen(),
            ],
          ),
          bottomNavigationBar: HomeNavBar(
            selectedIndex: home.selectedIndex,
            onChangedItemCallback: home.onChangedSelectedBottomBarItem,
          ),
        ),
      ),
    );
  }
}
