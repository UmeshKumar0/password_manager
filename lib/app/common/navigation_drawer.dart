import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/data_controller.dart';
import '../routes/app_pages.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DataController>(
      builder: (controller) {
        return Drawer(
          child: Column(
            children: [
              Expanded(
                  child: ListView(padding: EdgeInsets.zero, children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo2.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.cyan[700],
                  ),
                  accountName: Row(
                    children: [
                      Text(controller.user.value.name ?? 'NOT FOUND'),
                      const SizedBox(width: 10),
                      Text(controller.user.value.phnNumber ?? 'NOT FOUND')
                    ],
                  ),
                  accountEmail:
                      Text(controller.user.value.email ?? 'NOT FOUND'),
                  // currentAccountPicture: const CircleAvatar(     for User image
                  //   backgroundColor: Colors.transparent,
                  //   child: Icon(
                  //     Icons.supervised_user_circle_outlined,
                  //     //color: Colors.white,
                  //     size: 50,
                  //   ),
                  // ),
                  currentAccountPictureSize: const Size.fromRadius(30),
                ),
                controller.user.value.admin
                    ? ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text("Home"),
                        onTap: () {
                          Get.back();
                          Get.offAndToNamed(Routes.DASHBOARD);
                        },
                      )
                    : ListTile(
                        leading: const Icon(Icons.password),
                        title: const Text("My Password"),
                        onTap: () {
                          Get.back();
                          Get.offAndToNamed(Routes.USER_PASSWORDS);
                        },
                      ),
                controller.user.value.admin == null
                    ? Container()
                    : controller.user.value.admin == true
                        ? ListTile(
                            leading: const Icon(Icons.create),
                            title: const Text("Create User"),
                            onTap: () {
                              Get.back();
                              Get.offAndToNamed(Routes.CREATE_USER);
                            },
                          )
                        : const ListTile(),
                controller.user.value.admin == null
                    ? Container()
                    : controller.user.value.admin == true
                        ? ListTile(
                            leading: const Icon(Icons.password),
                            title: const Text("My Password"),
                            onTap: () {
                              Get.back();
                              Get.offAndToNamed(Routes.USER_PASSWORDS);
                            },
                          )
                        : const ListTile(),
                controller.user.value.admin == null
                    ? Container()
                    : controller.user.value.admin == true
                        ? ListTile(
                            leading: const Icon(Icons.data_exploration_sharp),
                            title: const Text("Activity Logs"),
                            onTap: () {
                              Get.back();
                              Get.offAndToNamed(Routes.ACTIVITY_LOGS);
                            },
                          )
                        : const ListTile(),
              ])),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Transform.scale(
                      scale: -1, child: const Icon(Icons.logout)),
                  title: const Text("LogOut"),
                  onTap: () {
                    GetStorage().remove('token');

                    Get.offAllNamed(AppPages.INITIAL);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
