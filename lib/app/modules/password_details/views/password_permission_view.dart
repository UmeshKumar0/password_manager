import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/password_details_controller.dart';

class PasswordPermissions extends StatelessWidget {
  PasswordPermissions({super.key, required this.controller});
  PasswordDetailsController controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField<dynamic>(
            decoration: const InputDecoration(
                label: Text("Add User"),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
            items: controller.allUserList.map((e) {
              return DropdownMenuItem(
                  value: e.sId, child: Text(e.name.toString()));
            }).toList(),
            onChanged: (value) {
              controller.addUserPermission(value);
            },
          ),
          GetBuilder<PasswordDetailsController>(
            builder: (controller) => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.passwordPermissions.length,
              itemBuilder: (context, index) {
                String? sid = controller.passwordPermissions[index].sId;
                return Obx(() {
                  return ExpansionTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    tilePadding: const EdgeInsets.all(20),
                    trailing: IconButton(
                        onPressed: () {
                          controller.deleteUserPermission(sid ?? "");
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        )),
                    title: Text(controller.passwordPermissions[index].user ??
                        "Not Found"),
                    subtitle: Text(
                        controller.passwordPermissions[index].email ??
                            "Not Found"),
                    children: [
                      ListTile(
                          leading: Checkbox(
                              value:
                                  controller.passwordPermissions[index].read ??
                                      false,
                              onChanged: null),
                          title: const Text('Read')),
                      ListTile(
                          leading: Checkbox(
                              value:
                                  controller.passwordPermissions[index].write ??
                                      false,
                              onChanged: (value) {
                                controller.permissionChange(
                                    "write", value, sid);
                              }),
                          title: const Text('Write')),
                      ListTile(
                          leading: Checkbox(
                              value:
                                  controller.passwordPermissions[index].share ??
                                      false,
                              onChanged: (value) {
                                controller.permissionChange(
                                    "share", value, sid);
                              }),
                          title: const Text('Share')),
                      ListTile(
                        leading: Checkbox(
                            value:
                                controller.passwordPermissions[index].delete ??
                                    false,
                            onChanged: (value) {
                              controller.permissionChange("del", value, sid);
                            }),
                        title: const Text('Delete'),
                      ),
                    ],
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
