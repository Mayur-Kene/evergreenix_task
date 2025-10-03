import 'package:evergreenix_task/data/repository/auth_repository.dart';
import 'package:evergreenix_task/representation/screens/home/home_screen.dart';
import 'package:evergreenix_task/representation/screens/auth/login_screen.dart';
import 'package:evergreenix_task/representation/widgets/app_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/source/local/app_storage.dart';
import '../widgets/toast.dart';

class AuthController extends GetxController {
  //repository
  final repository = AuthRepository();

  //for login
  final emailController = TextEditingController();
  final passController = TextEditingController();

  //for signup
  final nameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  //boolean values
  var isLoginButtonEnable = false;
  var isRegisterEnable = false;

  void validateLogin() {
    isLoginButtonEnable = emailController.text.isNotEmpty && passController.text.isNotEmpty;
    update();
  }

  void validateRegister() {
    isRegisterEnable = nameController.text.isNotEmpty &&
        registerEmailController.text.isNotEmpty &&
        phoneNoController.text.isNotEmpty &&
        newPassController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty;
    update();
  }

  void signIn() async {
    if (!validateLoginForm()) return;
    final body = {"email": emailController.text, "password": passController.text};
    AppLoader.showLoader();
    repository.signIn(body).then((response) {
      AppLoader.hideLoader();
      AppStorage.setValue(StorageKey.isLoggedIn, true);
      AppStorage.setValue(StorageKey.token, response['authToken']);
      AppStorage.setValue(StorageKey.email, emailController.text);
      Toast.success(message: "Log In Successfully");
      Get.to(HomeScreen());
    }, onError: (e) {
      AppLoader.hideLoader();
      Toast.error(message: '$e');
    });
  }

  void signUp() async {
    if (!validateSignupForm()) return;

    final body = {
      "name": nameController.text,
      "emailAddress": registerEmailController.text,
      "password": confirmPassController.text,
      "phoneNumber": "+91${phoneNoController.text}",
    };
    AppLoader.showLoader();
    repository.signUp(body).then((response) {
      AppLoader.hideLoader();
      Toast.success(message: "User Registered Successfully");
      Get.to(LoginScreen());
      clearControllers();
    }, onError: (e) {
      AppLoader.hideLoader();
      Toast.error(message: '$e');
    });
  }

  void logout() {
    AppStorage.logout();
    clearControllers();
    Get.offAll(() => LoginScreen());
  }

  bool validateSignupForm() {
    if (nameController.text.isEmpty ||
        registerEmailController.text.isEmpty ||
        phoneNoController.text.isEmpty ||
        newPassController.text.isEmpty ||
        confirmPassController.text.isEmpty) {
      Toast.error(message: "All fields are required");
      return false;
    }

    if (!GetUtils.isEmail(registerEmailController.text.trim())) {
      Toast.error(message: "Enter a valid email address");
      return false;
    }

    if (phoneNoController.text.trim().length != 10) {
      Toast.error(message: "Mobile number must be 10 digits");
      return false;
    }

    if (newPassController.text.length < 6) {
      Toast.error(message: "Password must be at least 6 characters long");
      return false;
    }

    if (newPassController.text != confirmPassController.text) {
      Toast.error(message: "Password and Confirm Password do not match");
      return false;
    }

    return true;
  }

  bool validateLoginForm() {
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Toast.error(message: "Enter a valid email");
      return false;
    }

    if (passController.text.length < 6) {
      Toast.error(message: "Password must be at least 6 characters long");
      return false;
    }

    return true;
  }

  void clearControllers() {
    nameController.clear();
    registerEmailController.clear();
    phoneNoController.clear();
    newPassController.clear();
    confirmPassController.clear();
    emailController.clear();
    passController.clear();
    isLoginButtonEnable = false;
    isRegisterEnable = false;
    update();
  }
}
