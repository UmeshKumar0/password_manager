import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controllers/data_controller.dart';
import '../../../network/get_connect.dart';
import '../model/get_all_user_model.dart';

class DashboardController extends GetxController {
  final dataController = Get.find<DataController>();

  RxList<GetAllUserModel> getAllUserData = <GetAllUserModel>[].obs;
  var width = Get.width;
  late PostsProvider _provider;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    _provider = PostsProvider();
    checkAllUserData();
    super.onInit();
  }

  Future<List<GetAllUserModel>> getAllUsers() async {
    isLoading(true);
    var response = await _provider.getCall("/user");
    
    if (!response.status.hasError) {
      getAllUserData.clear();
      Fluttertoast.showToast(msg: "Data Get Successfully");

      if (response.body.length > 0) {
        response.body.forEach((e) {
          getAllUserData.add(GetAllUserModel.fromJson(e));
        });
        refresh();
        getAllUserData.refresh();
      }

      isLoading(false);

      return getAllUserData;
    } else {
      Get.snackbar("Error", response.body.toString());
      isLoading(false);
      throw Exception("Failed to load data");
    }
  }

  checkAllUserData() {
    if (dataController.allUsers.isNotEmpty) {
      getAllUserData.value = dataController.allUsers;
    } else {
      getAllUsers();
    }
  }

  changeToAdmin(String id, bool isAdmin) async {
    isLoading(true);
    try {
      var response = await _provider.postCall("/user/createadmin",
          {"id": id, "makeAdmin": isAdmin}).timeout(const Duration(seconds: 5));

      if (!response.status.hasError) {
        Get.back();
        Fluttertoast.showToast(msg: "Admin set successfully");
      } else {
        Get.back();
        Get.snackbar("Error", response.body.toString());
        isLoading(false);
        throw Exception("Failed to create admin");
      }
    } on TimeoutException catch (e) {}
    getAllUsers();
    isLoading(false);
  }

  choiceAction(String choice, {var data}) {
    if (choice == Constants.firstItem) {
      Get.defaultDialog(
          title: "User Info",
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Name")),
                readOnly: true,
                initialValue: data.name,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Email")),
                readOnly: true,
                initialValue: data.email,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text("User created at")),
                readOnly: true,
                initialValue: data.createdAt,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Phone Number")),
                readOnly: true,
                initialValue: data.phnNumber,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Close")),
              )
            ],
          )).then((value) => getAllUsers());
    } else if (choice == Constants.secondItem) {
      final editNameController = TextEditingController(text: data.name);
      final editEmailController = TextEditingController(text: data.email);
      final editPhoneController = TextEditingController(text: data.phnNumber);

      Get.defaultDialog(
          title: "Edit Info",
          content: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Name")),
                controller: editNameController,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Email")),
                controller: editEmailController,
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Phone Number")),
                maxLength: 10,
                controller: editPhoneController,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(label: Text("Password")),
                initialValue: data.password,
                readOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () async {
                      Response response = await _provider.patchCall("/user", {
                        'userId': data.sId,
                        'name': editNameController.text,
                        'email': editEmailController.text,
                        'phnNumber': editPhoneController.text
                      });

                      if (response.statusCode == 200) {
                        Get.back();
                        Fluttertoast.showToast(
                            msg: "Data Updated Successfully");
                      } else {
                        Get.snackbar("Error", response.body.toString());

                        throw Exception("Failed to update data");
                      }
                    },
                    child: const Text("Update")),
              )
            ],
          )).then((value) => getAllUsers());
    } else if (choice == Constants.thirdItem) {
      Get.defaultDialog(
          title: "Delete User",
          content: Column(
            children: [
              const Text("Really want to delete user ?"),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      Response response =
                          await _provider.delCall("/user/${data.sId}");

                      if (response.statusCode == 200) {
                        Get.back(closeOverlays: true);
                        Fluttertoast.showToast(
                            msg: "User Deleted Successfully");
                      } else {
                        Get.snackbar("Error", response.body.toString());

                        throw Exception("Failed to delete user");
                      }
                    },
                    child: const Text("Delete")),
              )
            ],
          )).then((value) => getAllUsers());
    }
  }
}

class Constants {
  static const String firstItem = 'View';
  static const String secondItem = 'Edit';
  static const String thirdItem = 'Delete';

  static const List<String> choices = <String>[
    firstItem,
    secondItem,
    thirdItem,
  ];
}
