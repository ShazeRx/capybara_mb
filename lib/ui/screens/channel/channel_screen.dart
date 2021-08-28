import 'package:capybara_app/ui/widgets/channel/channel_list.dart';
import 'package:capybara_app/ui/widgets/chat/home_app_bar.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Channel;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: HomeAppBar(
        height: height * 0.1,
        title: routeArgs.title,
      ),
    );
  }
}
