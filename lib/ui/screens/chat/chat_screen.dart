import 'package:capybara_app/ui/widgets/channel/list/channel_arguments.dart';
import 'package:capybara_app/ui/widgets/home/home_app_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as ChannelArguments;
    return Scaffold(
      appBar: HomeAppBar(title: routeArgs.name),
    );
  }
}
