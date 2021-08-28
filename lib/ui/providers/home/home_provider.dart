import 'dart:async';

import 'package:capybara_app/ui/providers/base_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class HomeProvider extends BaseProvider implements Disposable {
  int selectedIndex = 0;
  String appBarTitle = 'Channels';
  late PageController pageController = PageController();

  onChangedSelectedBottomBarItem(int index) {
    this.selectedIndex = index;
    this.pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
    notifyListeners();
  }

  onPageChanged(int index) {
    this.selectedIndex = index;
    this.appBarTitle = this._getAppBarTitleOfCurrentScreen(index);
    notifyListeners();
  }

  String _getAppBarTitleOfCurrentScreen(int index) {
    if (index == 0) return 'Channels';
    if (index == 1) return 'Profile';
    return '';
  }

  @override
  FutureOr onDispose() {
    this.pageController.dispose();
  }
}
