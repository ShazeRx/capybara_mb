import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:capybara_app/core/helpers/ui/horizontal_space_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  HomeAppBar({
    required this.title,
    this.actions,
  });

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
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
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              //TODO - find a way to add svg here
              icon: Icon(Icons.arrow_back_ios),
            )
          : null,
      titleSpacing: 0,
      title: Row(
        children: [
          if (!Navigator.canPop(context))
            HorizontalSpaceHelper.horizontalSpaceLarge(context),
          if (!Navigator.canPop(context))
            SvgPicture.asset(
              SvgIcons.user,
              color: theme.iconTheme.color,
              height: 30,
            ),
          if (!Navigator.canPop(context))
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
                    fontSize: 12,
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
