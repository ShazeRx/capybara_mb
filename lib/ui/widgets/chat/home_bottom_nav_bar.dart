import 'package:flutter/material.dart';

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
      unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
      selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
      selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
      currentIndex: this.selectedIndex,
      onTap: (index) => this.onChangedItemCallback(index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Channels',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
