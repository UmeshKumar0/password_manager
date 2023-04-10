import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/navigation_drawer.dart';
import '../controllers/dashboard_controller.dart';
import 'user_list_item.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
        ),
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => controller.getAllUsers(),
                  child: GetBuilder<DashboardController>(
                    builder: (controller) => ListView.builder(
                      itemCount: controller.getAllUserData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.deepPurple[400],
                            elevation: 26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: UserItem(
                              user: controller.getAllUserData[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        }));
  }
}
