import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controllers/data_controller.dart';
import '../../../network/get_connect.dart';
import '../../dashboard/model/get_all_user_model.dart';
import '../../user_passwords/models/get_all_pass_model.dart';
import '../models/password_access_user.dart';
import '../models/permissions_user_model.dart';

class PasswordDetailsController extends GetxController {
  GetAllPassInfoModel password = GetAllPassInfoModel();
  GetAllPassInfoModel backupPassword = GetAllPassInfoModel();
  final dataController = Get.find<DataController>();
  RxList<GetAllUserModel> allUserList = <GetAllUserModel>[].obs;
  RxList<PasswordAccessUser> passwordUsers = <PasswordAccessUser>[].obs;
  RxList<PermissionsUserModel> passwordPermissions =
      <PermissionsUserModel>[].obs;

  RxBool showEdit = true.obs;
  late PostsProvider _provider;
  RxBool isLoading = false.obs;
  TextEditingController newPassword = TextEditingController();

  RxList<PassInfoData> data = <PassInfoData>[].obs;
  RxBool editMode = false.obs;

  void changevalue(value) {
    showEdit.value = value;
  }

  changeEditMode() {
    editMode.value = !editMode.value;
  }

  changeValueOfData(
      {required int index, required bool isKey, required String value}) {
    PassInfoData d = data[index];
    if (isKey) {
      d.key = value;
    } else {
      d.value = value;
    }
  }

  changeWebsiteName({required value}) {
    password.website = value;
  }

  changePassword({required value}) {
    password.password = value;
  }

  @override
  void onInit() {
    password = Get.arguments;
    backupPassword = Get.arguments;
    _provider = PostsProvider();

    getPasswordPermissions();
    data.clear();
    allUserList.value = dataController.allUsers;
    if (password.data != null) {
      for (PassInfoData element in password.data!) {
        data.add(element);
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    data.clear();
    super.onClose();
  }

  updatePassword() async {
    isLoading(true);
    /**
     * -> _id,
     * -> websiteName
     * -> password,
     * -> data [{key:key, value:value}]
     */
    try {
      Map<String, dynamic> body = {
        "id": password.sId,
        "website": password.website,
        "password":
            newPassword.text == "" ? password.password : newPassword.text,
        "data": [...data.map((element) => element.toJson())],
      };

      if (newPassword.text.isEmpty) {
        body.remove("password");
      }

      var response = await _provider.patchCall("/updatepassword", body);
      if (!response.status.hasError) {
        isLoading(false);
        Fluttertoast.showToast(msg: 'Password Updated...');
        editMode.value = false;
      } else {
        Get.snackbar("Error", response.body.toString());
        throw Exception("Failed to update data");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  getPasswordPermissions() async {
    var response = await _provider
        .postCall("/password/access", {"passwordId": password.sId});
    if (!response.status.hasError) {
      Fluttertoast.showToast(
          msg: "Permission Fetched ....", gravity: ToastGravity.BOTTOM);

      if (response.body['info'].length > 0) {
        passwordPermissions.clear();
        response.body['info'].forEach((e) {
          passwordPermissions.add(PermissionsUserModel.fromJson(e));
        });

        passwordPermissions.refresh();
        if (kDebugMode) {
          print(jsonEncode(passwordPermissions));
        }

        passwordUsers.refresh();
      } else {
        Get.snackbar("Error", response.body.toString());
      }
    }
  }

  permissionChange(String permissionType, bool? ab, String? userId) async {
    isLoading(true);
    var response = await _provider.postCall("/normaluserpermit",
        {"userId": userId, "passwordId": password.sId, permissionType: ab});

    if (!response.status.hasError) {
      Fluttertoast.showToast(
          msg: "Permission Changed ....", gravity: ToastGravity.BOTTOM);
      await getPasswordPermissions();
    } else {
      Get.snackbar("Error", response.body.toString());

      throw Exception("Failed to update data");
    }

    isLoading(false);
  }

  addUserPermission(String? userId) async {
    isLoading(true);
    var response = await _provider.postCall(
        "/password/permission", {"userId": userId, "passwordId": password.sId});
    if (!response.status.hasError) {
      Fluttertoast.showToast(
          msg: "User Added ....", gravity: ToastGravity.BOTTOM);
      await getPasswordPermissions();
      refresh();
    } else {
      Get.snackbar("Error", response.body.toString());

      throw Exception("Failed to update data");
    }
    isLoading(false);
  }

  deleteUserPermission(String userId) async {
    isLoading(true);
    var response =
        await _provider.delCall("/removeaccess/$userId/${password.sId}");

    if (response.status.hasError) {
      Get.snackbar("Error", response.body.toString());
      if (kDebugMode) {
        print(response.body.toString());
      }
      isLoading(false);
    } else {
      Fluttertoast.showToast(
          msg: "User Deleted ....", gravity: ToastGravity.BOTTOM);
      await getPasswordPermissions();
      refresh();
    }

    isLoading(false);
  }
}
