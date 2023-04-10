import 'package:get/instance_manager.dart';

import 'data_controller.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController());
  }
}
