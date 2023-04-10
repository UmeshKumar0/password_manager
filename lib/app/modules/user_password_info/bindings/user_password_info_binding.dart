import 'package:get/get.dart';

import '../controllers/user_password_info_controller.dart';

class UserPasswordInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPasswordInfoController>(
      () => UserPasswordInfoController(),
    );
  }
}
