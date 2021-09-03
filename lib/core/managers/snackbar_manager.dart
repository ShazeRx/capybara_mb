import 'package:capybara_app/core/config/themes/default_theme/default_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SnackbarManager {
  void showSuccess(String success);

  void showInfo(String info);

  void showWarning(String warning);

  void showError(String error);
}

class SnackbarManagerImpl implements SnackbarManager {
  //TODO - add different snackbars

  void showSuccess(String success) {
    Get.snackbar(
      'Success',
      success,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: DefaultColors.successColor,
    );
  }

  void showInfo(String info) {
    Get.snackbar(
      'Info',
      info,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: DefaultColors.infoColor,
    );
  }

  void showWarning(String warning) {
    Get.snackbar(
      'Warning',
      warning,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: DefaultColors.warningColor,
      colorText: Colors.black87,
    );
  }

  void showError(String error) {
    Get.snackbar(
      'Error',
      error,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: DefaultColors.errorColor,
    );
  }
}
