import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_name_provider.dart';
import 'package:capybara_app/ui/widgets/home/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewChannelNameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final memberListIds =
        ModalRoute.of(context)!.settings.arguments as List<int>;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => getIt<NewChannelNameProvider>(),
      child: Consumer<NewChannelNameProvider>(
        builder: (_, newChannelName, __) => Scaffold(
          appBar: HomeAppBar(title: 'New channel name'),
          body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: height * 0.2),
              width: width * 0.6,
              child: TextFormField(
                controller: newChannelName.channelNameController,
                style: theme.inputDecorationTheme.hintStyle,
                decoration: defaultInputDecoration(hintText: 'Name'),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: SvgPicture.asset(
              SvgIcons.plus,
              color: theme.iconTheme.color,
            ),
            onPressed: () {
              newChannelName.onAddChannelClicked(memberListIds);
            },
          ),
        ),
      ),
    );
  }
}
