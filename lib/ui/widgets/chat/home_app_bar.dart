import 'package:capybara_app/core/helpers/ui/horizontal_space_helper.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final List<Widget>? actions;
  final bool isChannelsScreen;

  HomeAppBar({
    required this.title,
    required this.height,
    this.actions,
    this.isChannelsScreen = false,
  });

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(this.height);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      title: Row(
        children: [
          if (widget.isChannelsScreen)
            Icon(
              Icons.supervised_user_circle,
            ),
          if (widget.isChannelsScreen)
            HorizontalSpaceHelper.horizontalSpaceLarge(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: theme.appBarTheme.titleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                //TODO - add network connection checking
                child: const Text(
                  'No connection',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: widget.actions,
    );
  }
}
