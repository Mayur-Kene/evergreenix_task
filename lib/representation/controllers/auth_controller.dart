import 'package:evergreenix_task/data/repository/auth_repository.dart';
import 'package:evergreenix_task/representation/screens/home_screen.dart';
import 'package:evergreenix_task/representation/screens/login_screen.dart';
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
    isLoginButtonEnable =
        emailController.text.isNotEmpty && passController.text.isNotEmpty;
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
    if (!validateEmail(emailController)) {
      Toast.error(message: "Enter a valid email");
      return;
    }
    final body = {
      "email": emailController.text,
      "password": passController.text
    };
    AppLoader.showLoader();
    repository.signIn(body).then((response) {
      AppLoader.hideLoader();
      AppStorage.setValue(StorageKey.isLoggedIn, true);
      AppStorage.setValue(StorageKey.token, response['authToken']);
      Toast.success(message: "Success");
      Get.to(HomeScreen());
    }, onError: (e) {
      AppLoader.hideLoader();
      Toast.error(message: '$e');
    });
  }

  void signUp() async {
    if (!validateEmail(registerEmailController)) {
      Toast.error(message: "Enter a valid email");
      return;
    }
    if (!validatePasswordsMatch()) {
      Toast.error(message: "Password and Confirm Password do not match");
      return;
    }
    final body = {
      "name": nameController.text,
      "emailAddress": registerEmailController.text,
      "password": confirmPassController.text,
      "phoneNumber": "+91${phoneNoController.text}",
    };
    AppLoader.showLoader();
    repository.signUp(body).then((response) {
      AppLoader.hideLoader();
      // AppStorage.setValue(StorageKey.token, response['authToken']);
      Toast.success(message: "User Registered Successfully");
      Get.to(LoginScreen());
      clearControllers();
    }, onError: (e) {
      AppLoader.hideLoader();
      Toast.error(message: '$e');
    });
  }

  void logout() {
    // Clear saved token and login state
    AppStorage.logout();
    clearControllers();


    // Navigate to Login Screen and remove HomeScreen from stack
    Get.offAll(() => LoginScreen());
  }

  bool validateEmail(TextEditingController controller) {
    return GetUtils.isEmail(controller.text.trim());
  }

  bool validatePasswordsMatch() {
    return newPassController.text == confirmPassController.text;
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
    isRegisterEnable = false; // reset button state
    update();
  }
}
