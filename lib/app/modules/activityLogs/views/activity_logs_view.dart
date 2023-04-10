import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:password_manager/app/common/navigation_drawer.dart';
import 'package:password_manager/app/modules/activityLogs/views/logs_list_item.dart';

import '../controllers/activity_logs_controller.dart';

class ActivityLogsView extends GetView<ActivityLogsController> {
  const ActivityLogsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ),
                items: controller.logType.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.filterLogs(value?.toLowerCase() ?? "");
                  // dashboardController.choiceAction(value ?? "",
                  //     data: widget.user);
                },
              ),
            ),
          ),
        ],
        title: const Text('Activity Logs'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? RefreshIndicator(
                  onRefresh: () => controller.getAllLogs(),
                  child: GetBuilder<ActivityLogsController>(
                    builder: (controller) => ListView.builder(
                      itemCount: controller.logsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.deepPurple[400],
                            elevation: 26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: LogsItem(
                              logs: controller.logsList[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
