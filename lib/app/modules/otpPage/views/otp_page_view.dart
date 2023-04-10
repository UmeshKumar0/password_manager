import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../routes/app_pages.dart';
import '../controllers/otp_page_controller.dart';

class OtpPageView extends GetView<OtpPageController> {
  const OtpPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Form(
                key: controller.formKeyOtp,
                child: Column(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: controller.height * 0.2,
                            ),
                            Icon(Icons.onetwothree_sharp,
                                size: controller.height * 0.09),
                          ],
                        )),
                    Flexible(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          height: controller.height * 0.4,
                          width: controller.width * 0.8,
                          child: Column(children: [
                            SizedBox(
                              height: controller.height * 0.1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PinCodeTextField(
                                onChanged: (value) {},
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(
                                      RegExp("[a-zA-Z]")),
                                ],
                                controller: controller.otpController,
                                appContext: context,
                                length: 6,
                                validator: (value) {
                                  if (value != null) {
                                    if (value.length < 6) {
                                      Future.delayed(
                                          const Duration(milliseconds: 0), () {
                                        controller.isEnabled.value = false;
                                      });
                                      return "Please Enter valid OTP";
                                    } else {
                                      Future.delayed(
                                          const Duration(milliseconds: 0), () {
                                        controller.isEnabled.value = true;
                                      });
                                    }
                                  } else {
                                    return "Enter OTP";
                                  }
                                },
                                onCompleted: (value) {
                                  controller.verifyOTP();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Obx(
                                      () => RichText(
                                          text: TextSpan(
                                              text: "Didn't recieve OTP ? ",
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13),
                                              children: [
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = controller
                                                              .resendTimeOut
                                                              .value
                                                          ? () {}
                                                          : () async {
                                                              controller
                                                                  .resendOTP();
                                                            },
                                                text: "Resend OTP ",
                                                style: TextStyle(
                                                    color: controller
                                                            .resendTimeOut.value
                                                        ? Colors.grey
                                                        : Colors.blue)),
                                            controller.resendTimeOut.value
                                                ? TextSpan(
                                                    text:
                                                        " 00:${controller.resendAfter} sec")
                                                : const TextSpan()
                                          ])),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Change phone number ? ",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13),
                                        children: [
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  Get.offAndToNamed(
                                                    Routes.LOGIN,
                                                  );
                                                },
                                              text: "Change number",
                                              style: const TextStyle(
                                                  color: Colors.blue))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: controller.height * 0.02,
                            ),
                          ]),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
