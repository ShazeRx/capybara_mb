import 'package:capybara_app/ui/widgets/chat/home_app_bar.dart';
import 'package:flutter/material.dart';

class NewChannelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: HomeAppBar(
        title: 'New channel',
        height: height * 0.1,
      ),
    );
  }
}
