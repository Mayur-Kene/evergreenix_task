import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';

class Toast {
  static success({required String message}) {
    _private(message, Colors.green, Icons.check_circle_outline_rounded);
  }

  static error({required String message}) {
    _private(message, Colors.redAccent, Icons.error_outline_rounded);
  }

  static _private(String message, Color color, IconData data) {
    Get.closeAllSnackbars();
    Get.showSnackbar(
      GetSnackBar(
        messageText:
            Text(message, style: AppTheme.textStyle(weight: FontWeight.w500, color: Colors.white)),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        borderRadius: 4,
        backgroundColor: color,
        duration: const Duration(milliseconds: 3000),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.up,
        icon: Icon(data, color: Colors.white),
      ),
    );
  }
}
