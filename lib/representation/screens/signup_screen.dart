import 'package:evergreenix_task/representation/controllers/auth_controller.dart';
import 'package:evergreenix_task/representation/screens/login_screen.dart';
import 'package:evergreenix_task/representation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';
import '../themes/colors.dart';
import '../widgets/app_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: primary, // solid dark navy background
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 60,
                height: 60,
              ).marginOnly(bottom: 15),
              Text(
                "Create Account",
                style: AppTheme.textStyle(size: 26, weight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account ?",
                    style: AppTheme.textStyle(size: 14),
                  ),
                  TextButton(
                    onPressed: () {

                      Get.offAll(LoginScreen());
                      controller.clearControllers();
                    },
                    child: Text(
                      "Login",
                      style: AppTheme.textStyle(
                          size: 14, weight: FontWeight.w600, color: blue),
                    ),
                  ),
                ],
              ),
              CustomInputField(
                  icon: Icons.person,
                  hintText: "Name",
                  onChanged: (value) {
                    controller.validateRegister();
                  },
                  controller: controller.nameController),
              CustomInputField(
                  icon: Icons.email_outlined,
                  hintText: "Email",
                  onChanged: (value) {
                    controller.validateRegister();
                  },
                  controller: controller.registerEmailController),
              CustomInputField(
                  icon: Icons.phone_android_outlined,
                  hintText: "Phone No",
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: (value) {
                    controller.validateRegister();
                  },
                  controller: controller.phoneNoController),
              CustomInputField(
                icon: Icons.password_outlined,
                hintText: "Password",
                onChanged: (value) {
                  controller.validateRegister();
                },
                controller: controller.newPassController,
                isPassword: true,
              ),
              CustomInputField(
                icon: Icons.password_outlined,
                hintText: "Confirm Password",
                onChanged: (value) {
                  controller.validateRegister();
                },
                controller: controller.confirmPassController,
                isPassword: true,
              ),
              AppButton(
                title: "Register",
                enable: controller.isRegisterEnable,
                onPressed: () {
                  controller.signUp();
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
