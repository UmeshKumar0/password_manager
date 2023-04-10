import 'package:get/get.dart';

import '../controllers/user_passwords_controller.dart';

class UserPasswordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPasswordsController>(
      () => UserPasswordsController(),
    );
  }
}
