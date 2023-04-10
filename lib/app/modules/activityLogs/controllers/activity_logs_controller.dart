import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/modules/activityLogs/models/get_all_logs_model.dart';
import 'package:password_manager/app/network/get_connect.dart';

import '../models/logs_model.dart';

class ActivityLogsController extends GetxController {
  //TODO: Implement ActivityLogsController
  late PostsProvider _provider;
  RxList<LogsModel> logsList = <LogsModel>[].obs;
  RxBool isLoading = false.obs;

  List<String> logType = ["Create", "Update", "Delete", "Share"];
  @override
  void onInit() {
    // TODO: implement onInit
    _provider = PostsProvider();

    getAllLogs();
    super.onInit();
  }

  getAllLogs() async {
    isLoading.value = false;
    logsList.clear();
    var response = await _provider.getCall("/alllogs");
    if (response.statusCode == 200) {
      response.body.forEach((e) {
        print(e);
        logsList.add(LogsModel.fromJson(e));
      });

      Fluttertoast.showToast(msg: "Logs fetched successfully");
      isLoading.value = true;
    } else {
      if (response.body["message"] == null) {
        Get.snackbar("Error", "Something went wrong");
      } else {
        Get.snackbar("Error", response.body["message"]);
      }
    }
    isLoading.value = true;
  }

  void filterLogs(String s) async {
    isLoading.value = false;

    logsList.clear();
    await getAllLogs();
    RxList<LogsModel> result = <LogsModel>[].obs;

    result.value = logsList.value
        .where((data) => data.level!.toLowerCase().contains(s.toLowerCase()))
        .toList();

    refresh();
    logsList = result;

    isLoading.value = true;
  }
}
