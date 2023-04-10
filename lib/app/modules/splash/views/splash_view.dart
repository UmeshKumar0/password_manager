import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Center(
                child: Image(image: AssetImage("assets/images/logo2.png")),
              );
      }),
    );
  }
}
