import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/data_controller.dart';
import '../controllers/password_details_controller.dart';
import 'password_edit_view.dart';
import 'password_permission_view.dart';

class PasswordDetailsView extends GetView<PasswordDetailsController> {
  const PasswordDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<DataController>(
      builder: (dataController) {
        return dataController.user.value.admin
            ? DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.red[100],
                  appBar: AppBar(
                    title: Text(controller.password.website ?? "NOT FOUND"),
                    centerTitle: true,
                    actions: [
                      Obx(() {
                        return controller.isLoading.isTrue
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 10,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  ),
                                ),
                              )
                            : Container();
                      })
                    ],
                    bottom: TabBar(
                      indicatorColor: Colors.white,
                      onTap: (value) {
                        if (value == 1) {
                          controller.changevalue(false);
                        } else {
                          controller.changevalue(true);
                        }
                      },
                      tabs: const [
                        Tab(
                          text: "Details",
                        ),
                        Tab(
                          text: "Permissions",
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      PasswordDetails(
                        controller: controller,
                      ),
                      PasswordPermissions(
                        controller: controller,
                      ),
                    ],
                  ),
                  floatingActionButton: Obx(() {
                    return controller.showEdit.isTrue
                        ? FloatingActionButton(
                            onPressed: () {
                              controller.changeEditMode();
                            },
                            child: Icon(
                              controller.editMode.isTrue
                                  ? Icons.clear
                                  : Icons.edit,
                              color: Colors.white,
                            ),
                          )
                        : Container();
                  }),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: const Text("Password Details" ),
                  centerTitle: true,
                ),
                body: PasswordDetails(controller: controller),
                floatingActionButton: Obx(() {
                  return controller.showEdit.isTrue
                      ? FloatingActionButton(
                          onPressed: () {
                            controller.changeEditMode();
                          },
                          child: Icon(
                            controller.editMode.isTrue
                                ? Icons.clear
                                : Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      : Container();
                }),
              );
      },
    );
  }
}
