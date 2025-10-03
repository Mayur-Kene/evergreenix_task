import 'package:animate_do/animate_do.dart';
import 'package:evergreenix_task/representation/screens/home/home_screen.dart';
import 'package:evergreenix_task/representation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/source/local/app_storage.dart';
import '../../themes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      final logged = AppStorage.valueFor(StorageKey.isLoggedIn) ?? false;
      if (logged) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.offAll(() => const HomeScreen());
        });
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: ElasticIn(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              SvgPicture.asset('assets/icons/logo.svg', height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
