import 'package:evergreenix_task/representation/controllers/auth_controller.dart';
import 'package:evergreenix_task/representation/themes/app_theme.dart';
import 'package:evergreenix_task/representation/themes/colors.dart';
import 'package:evergreenix_task/representation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/source/local/app_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = AppStorage.valueFor(StorageKey.email);
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        backgroundColor: primary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to the Account",
                style: AppTheme.textStyle(color: Colors.white, size: 22),
              ),
              Text(
                userEmail,
                style: AppTheme.textStyle(color: Colors.white, size: 16),
              ),
              AppButton(
                title: "Log Out",
                enable: true,
                onPressed: () {
                  controller.logout();
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
