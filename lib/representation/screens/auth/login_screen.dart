import 'package:evergreenix_task/representation/controllers/auth_controller.dart';
import 'package:evergreenix_task/representation/screens/auth/signup_screen.dart';

import 'package:evergreenix_task/representation/themes/colors.dart';
import 'package:evergreenix_task/representation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../themes/app_theme.dart';
import '../../widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: primary,
          resizeToAvoidBottomInset: true,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: 60,
                    height: 60,
                  ).marginOnly(bottom: 15),
                  Text(
                    "Log in to your Account",
                    style: AppTheme.textStyle(size: 26, weight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: AppTheme.textStyle(size: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(SignupScreen());
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTheme.textStyle(size: 16, weight: FontWeight.w600, color: blue),
                        ),
                      ),
                    ],
                  ),
                  CustomInputField(
                      icon: Icons.email_outlined,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 30,
                      onChanged: (value) {
                        controller.validateLogin();
                      },
                      controller: controller.emailController),
                  CustomInputField(
                    icon: Icons.password_outlined,
                    hintText: "Password",
                    maxLength: 24,
                    onChanged: (value) {
                      controller.validateLogin();
                    },
                    controller: controller.passController,
                    isPassword: true,
                  ),
                  AppButton(
                    title: "Log In",
                    enable: controller.isLoginButtonEnable,
                    onPressed: () {
                      controller.signIn();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
