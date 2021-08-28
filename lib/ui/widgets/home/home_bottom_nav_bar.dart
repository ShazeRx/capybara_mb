import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onChangedItemCallback;

  HomeNavBar({
    required this.selectedIndex,
    required this.onChangedItemCallback,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BottomNavigationBar(
      showUnselectedLabels: false,
      selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
      currentIndex: this.selectedIndex,
      onTap: (index) => this.onChangedItemCallback(index),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            SvgIcons.channel,
            height: 25,
            color: this.selectedIndex == 0
                ? theme.bottomNavigationBarTheme.selectedItemColor
                : theme.bottomNavigationBarTheme.unselectedItemColor,
          ),
          label: 'Channels',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            SvgIcons.user,
            height: 25,
            color: this.selectedIndex == 1
                ? theme.bottomNavigationBarTheme.selectedItemColor
                : theme.bottomNavigationBarTheme.unselectedItemColor,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
