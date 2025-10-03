


import 'package:evergreenix_task/representation/controllers/auth_controller.dart';
import 'package:get/get.dart';


class AuthBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(),fenix: true);
  }


}