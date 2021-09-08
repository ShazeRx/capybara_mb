import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/providers/channels/channel_provider.dart';
import 'package:capybara_app/ui/states/channel/channel_state_notifier.dart';
import 'package:capybara_app/ui/widgets/channel/list/channel_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChannelsScreen extends StatefulWidget {
  @override
  _ChannelsScreenState createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     getIt<ChannelProvider>().fetchChannels();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return
        ChangeNotifierProvider(create:(_)=>  getIt<ChannelProvider>(),
      child: Consumer<ChannelProvider>(
        builder: (_, channel, __) {
          return channel.state == ProviderState.busy
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        RoutePaths.newChannelMembersRoute,
                      );
                    },
                    child: SvgPicture.asset(
                      SvgIcons.plus,
                      color: theme.iconTheme.color,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      children: [
                        ChannelList(),
                        //NewChannelListTile(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
