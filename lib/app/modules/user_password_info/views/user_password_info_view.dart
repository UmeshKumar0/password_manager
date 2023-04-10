import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_password_info_controller.dart';

class UserPasswordInfoView extends GetView<UserPasswordInfoController> {
  const UserPasswordInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Passwords'),
          centerTitle: true,
        ),
        body: Obx(() {
          return controller.isLoading.isFalse
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: controller.userPassList.isNotEmpty
                      ? GetBuilder<UserPasswordInfoController>(
                          builder: (controller) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.userPassList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Website : ",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                            .userPassList[index]
                                                            .website ??
                                                        "Not Found",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Password : ",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                                .userPassList[
                                                                    index]
                                                                .password !=
                                                            ""
                                                        ? "**********"
                                                        : "",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Created At : ",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                        .userPassList[index]
                                                        .createdAt,
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "No Data Found",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                );
        }));
  }
}
