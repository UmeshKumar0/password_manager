import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/data_controller.dart';
import '../../../network/get_connect.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/model/get_user_info_model.dart';

class OtpPageController extends GetxController {
  TextEditingController otpController = TextEditingController();
  late DataController dataController;
  RxBool isEnabled = false.obs;
  double height = Get.height;
  double width = Get.width;
  GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>();
  RxBool resendTimeOut = false.obs;
  RxBool loading = false.obs;
  RxInt resendAfter = 60.obs;
  final local = GetStorage();

  late PostsProvider _provider;
  late var mobileNumber;
  var timer;

  @override
  void onInit() async {
    dataController = Get.find<DataController>();
    _provider = PostsProvider();
    mobileNumber = Get.arguments;
    super.onInit();
  }

  resendOTP() async {
    loading(true);
    var response = await _provider.postCall("/otp", {
      'phnNumber': mobileNumber,
    });

    if (!response.status.hasError) {
      Fluttertoast.showToast(msg: "OTP Resend successfully");

      Future.delayed(const Duration(milliseconds: 0), () {
        resendTimeOut.value = true;
        startResendOtpTimer();
      });
      Future.delayed(const Duration(minutes: 1), () {
        resendTimeOut.value = false;
      });
    } else {
      Get.snackbar("Error", response.body.toString());
    }
    loading(false);
  }

  startResendOtpTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value--;
      } else {
        resendAfter.value = 60;
        resendTimeOut.value = false;
        timer.cancel();
      }
      update();
    });
  }

  verifyOTP() async {
    loading(true);
    var response = await _provider.postCall(
        "/verifyOtp", {'phnNumber': mobileNumber, 'otp': otpController.text});

    if (!response.status.hasError) {
      Fluttertoast.showToast(msg: "OTP Verified successfully");

      print(response.body['admin']);
      print(response.body['token']);
      local.write("token", response.body["token"]);
      local.write("user", json.encode(response.body));
      dataController.setUser(user: GetUserInfoModel.fromJson(response.body));
      if (response.body['admin'] == false) {
        Get.offAllNamed(Routes.USER_PASSWORDS);
      } else {
        Get.offAndToNamed(Routes.DASHBOARD);
      }
    } else {
      if (response.statusCode == 400) {
        Get.snackbar("OTP not valid", "Please try again");
      } else {
        Get.snackbar(response.body.toString(), "Please try again");
      }
    }
    otpController.clear();
    loading(false);
  }
}
