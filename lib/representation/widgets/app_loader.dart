import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';
import '../themes/colors.dart';

class AppLoader {
  static bool _isLoading = false;

  static void showLoader({String message = 'Loading...'}) {
    if (_isLoading == false) {
      FocusManager.instance.primaryFocus?.unfocus();
      _isLoading = true;
      Get.dialog(
        Material(
          color: Colors.transparent,
          child: PopScope(
            canPop: false,
            child: Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: primary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      style: AppTheme.textStyle(size: 13, color: primary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  static void hideLoader() {
    if (_isLoading) {
      _isLoading = false;
      Get.back();
    }
  }
}
