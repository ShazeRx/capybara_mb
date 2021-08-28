import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/ui/screens/auth/login_screen.dart';
import 'package:capybara_app/ui/screens/auth/register_screen.dart';
import 'package:capybara_app/ui/screens/channel/channel_screen.dart';
import 'package:capybara_app/ui/screens/channel/channels_screen.dart';
import 'package:capybara_app/ui/screens/home/home_screen.dart';
import 'package:capybara_app/ui/screens/chat/new_channel_screen.dart';
import 'package:capybara_app/ui/screens/profile/user_profile_screen.dart';

import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      RoutePaths.loginRoute: (ctx) => LoginScreen(),
      RoutePaths.registerRoute: (ctx) => RegisterScreen(),
      RoutePaths.channelsRoute: (ctx) => ChannelsScreen(),
      RoutePaths.newChannelRoute: (ctx) => NewChannelScreen(),
      RoutePaths.homeRoute: (ctx) => HomeScreen(),
      RoutePaths.userProfileRoute: (ctx) => UserProfileScreen(),
      RoutePaths.channelRoute: (ctx) => ChannelScreen(),
    };
