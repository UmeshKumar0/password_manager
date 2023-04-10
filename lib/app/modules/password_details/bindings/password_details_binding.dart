import 'package:get/get.dart';

import '../controllers/password_details_controller.dart';

class PasswordDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordDetailsController>(
      () => PasswordDetailsController(),
    );
  }
}
