import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
   LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Form(
              key:formKeyLogin,
              child: Column(
                children: [
                  Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: controller.height * 0.2,
                          ),
                          Icon(Icons.supervised_user_circle,
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
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.deny(
                                    RegExp("[a-zA-Z]")),
                              ],
                              controller: controller.mobileNumberController,
                              validator: (value) {
                                if (value != null) {
                                  if (value.length < 10) {
                                    Future.delayed(
                                        const Duration(milliseconds: 0), () {
                                      controller.isEnabled.value = false;
                                    });
                                    return "Number must be atleast 10 digit";
                                  } else {
                                    Future.delayed(
                                        const Duration(milliseconds: 0), () {
                                      controller.isEnabled.value = true;
                                    });
                                  }
                                } else {
                                  return "Enter Mobile number";
                                }
                              },
                              maxLength: 10,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: const Text("Mobile"),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32))),
                            ),
                          ),
                          SizedBox(
                            height: controller.height * 0.02,
                          ),
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: controller.isEnabled.value
                                    ? () {
                                        if (formKeyLogin.currentState!
                                            .validate()) {
                                          controller.sendOtp();
                                        }
                                      }
                                    : null,
                                child: const Text('Log In',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ]),
                      ))
                ],
              ),
            )),
    );
  }
}
