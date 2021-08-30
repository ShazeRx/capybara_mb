import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/ui/screens/auth/login_screen.dart';
import 'package:capybara_app/ui/screens/auth/register_screen.dart';
import 'package:capybara_app/ui/screens/channel/channels_screen.dart';
import 'package:capybara_app/ui/screens/channel/new_channel_name_screen.dart';
import 'package:capybara_app/ui/screens/chat/chat_screen.dart';
import 'package:capybara_app/ui/screens/home/home_screen.dart';
import 'package:capybara_app/ui/screens/channel/new_channel_members_screen.dart';
import 'package:capybara_app/ui/screens/profile/user_profile_screen.dart';

import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      RoutePaths.loginRoute: (ctx) => LoginScreen(),
      RoutePaths.registerRoute: (ctx) => RegisterScreen(),
      RoutePaths.channelsRoute: (ctx) => ChannelsScreen(),
      RoutePaths.newChannelMembersRoute: (ctx) => NewChannelMembersScreen(),
      RoutePaths.homeRoute: (ctx) => HomeScreen(),
      RoutePaths.userProfileRoute: (ctx) => UserProfileScreen(),
      RoutePaths.chatRoute: (ctx) => ChatScreen(),
      RoutePaths.newChannelNameRoute: (ctx) => NewChannelNameScreen(),
    };
