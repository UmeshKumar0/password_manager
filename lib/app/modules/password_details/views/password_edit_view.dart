import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/password_details_controller.dart';

class PasswordDetails extends StatelessWidget {
  PasswordDetails({
    super.key,
    required this.controller,
  });
  PasswordDetailsController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) =>
                        controller.changeWebsiteName(value: value),
                    enabled: controller.editMode.value,
                    initialValue: controller.password.website,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) =>
                        controller.changePassword(value: value),
                    enabled: controller.editMode.value,
                    controller: controller.newPassword,
                    decoration: const InputDecoration(
                      label: Text("New Password"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: TextFormField(
                                enabled: controller.editMode.value,
                                initialValue: controller.data[index].key,
                                onChanged: (value) {
                                  controller.changeValueOfData(
                                    index: index,
                                    isKey: true,
                                    value: value,
                                  );
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                            
                              padding: const EdgeInsets.only(left: 5),
                              child: TextFormField(
                                enabled: controller.editMode.value,
                                initialValue: controller.data[index].value,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  controller.changeValueOfData(
                                    index: index,
                                    isKey: false,
                                    value: value,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
                },
                itemCount: controller.data.length,
              ),
              Obx(() {
                return controller.editMode.isTrue
                    ? ElevatedButton(
                        onPressed: () {
                          controller.updatePassword();
                        },
                        child: const Text("Update"),
                      )
                    : Container();
              })
            ],
          ),
        ));
  }
}
