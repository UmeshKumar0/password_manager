import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../network/get_connect.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController mobileNumberController = TextEditingController();
  RxBool isEnabled = false.obs;
  double height = Get.height;
  double width = Get.width;

  RxBool loading = false.obs;
  late PostsProvider _provider;

  final count = 0.obs;
  @override
  void onInit() {
    _provider = PostsProvider();
    super.onInit();
  }

  @override
  void onClose() {
    mobileNumberController.clear();
    // formKeyLogin.currentState?.dispose();
    super.onClose();
  }

  sendOtp() async {
    loading(true);
    var response = await _provider.postCall("/otp", {
      'phnNumber': mobileNumberController.text,
    });

    if (!response.status.hasError) {
      Fluttertoast.showToast(msg: "OTP Send successfully");

      Get.offAndToNamed(Routes.OTP_PAGE,
          arguments: mobileNumberController.text);
      mobileNumberController.clear();
    } else {
      Get.snackbar("Error", "Server not responding");
    }
    loading(false);
  }
}
