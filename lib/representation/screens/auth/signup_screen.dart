import 'package:evergreenix_task/representation/controllers/auth_controller.dart';
import 'package:evergreenix_task/representation/screens/auth/login_screen.dart';
import 'package:evergreenix_task/representation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../themes/app_theme.dart';
import '../../themes/colors.dart';
import '../../widgets/app_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: 60,
                    height: 60,
                  ).marginOnly(bottom: 15, top: 20),
                  Text(
                    "Create Account",
                    style: AppTheme.textStyle(size: 28, weight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account ?",
                        style: AppTheme.textStyle(size: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.clearControllers();
                          Get.offAll(const LoginScreen());
                        },
                        child: Text(
                          "Login",
                          style: AppTheme.textStyle(size: 16, weight: FontWeight.w600, color: blue),
                        ),
                      ),
                    ],
                  ),
                  CustomInputField(
                    icon: Icons.person,
                    hintText: "Name",
                    maxLength: 40,
                    onChanged: (_) => controller.validateRegister(),
                    controller: controller.nameController,
                  ),
                  CustomInputField(
                    icon: Icons.email_outlined,
                    hintText: "Email",
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => controller.validateRegister(),
                    controller: controller.registerEmailController,
                  ),
                  CustomInputField(
                    icon: Icons.phone_android_outlined,
                    hintText: "Phone No",
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: (_) => controller.validateRegister(),
                    controller: controller.phoneNoController,
                  ),
                  CustomInputField(
                    icon: Icons.password_outlined,
                    hintText: "Password",
                    maxLength: 24,
                    onChanged: (_) => controller.validateRegister(),
                    controller: controller.newPassController,
                    isPassword: true,
                  ),
                  CustomInputField(
                    icon: Icons.password_outlined,
                    hintText: "Confirm Password",
                    maxLength: 24,
                    onChanged: (_) => controller.validateRegister(),
                    controller: controller.confirmPassController,
                    isPassword: true,
                  ),
                  AppButton(
                    title: "Register",
                    enable: controller.isRegisterEnable,
                    onPressed: () => controller.signUp(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
