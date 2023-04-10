import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../network/get_connect.dart';
import '../models/get_all_pass_model.dart';

class UserPasswordsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<GetAllPassInfoModel> getAllPassData = <GetAllPassInfoModel>[].obs;
  RxList<GetAllPassInfoModel> searchResults = <GetAllPassInfoModel>[].obs;
  late PostsProvider _provider;

  @override
  void onInit() {
    _provider = PostsProvider();
    getAllPass();
    searchResults = getAllPassData;
    super.onInit();
  }

  deleteUser(String id) async {
    Response response = await _provider.delCall("/password/$id");

    if (response.statusCode == 200) {
      Get.back(closeOverlays: true);
      Fluttertoast.showToast(msg: "User Deleted Successfully");
    } else {
      Get.snackbar("Error", response.body.toString());

      throw Exception("Failed to delete user");
    }
  }

  Future<List<GetAllPassInfoModel>> getAllPass() async {
    isLoading(true);
    var response = await _provider.getCall("/password");
    if (!response.status.hasError) {
      getAllPassData.clear();
      Fluttertoast.showToast(msg: "Data fetch successfully");

      var data;
     
      if (response.body.runtimeType != List<dynamic>) {
        data = response.body['userPassword'];
      } else {
        data = response.body;
      }
      if (data.length > 0) {
        data.forEach((e) {
          getAllPassData.add(GetAllPassInfoModel.fromJson(e));
        });

        refresh();
        getAllPassData.refresh();
      }
      isLoading(false);
      return getAllPassData;
    } else {
      Get.snackbar("Error", response.body.toString());
      isLoading(false);
      throw Exception("Failed to load data");
    }
  }

  void runFilter(String enteredKeyword) {
    RxList<GetAllPassInfoModel> result = <GetAllPassInfoModel>[].obs;

    if (enteredKeyword.isEmpty) {
      result = getAllPassData;
    } else {
      // ignore: invalid_use_of_protected_member
      result.value = getAllPassData.value
          .where((data) => data.website!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    refresh();
    searchResults = result;
  }

  copyPasswordToClipboard(String userId) async {
    var response = await _provider.getCall("/password/hidepassword/$userId");
    if (!response.status.hasError) {
      Clipboard.setData(ClipboardData(text: response.body)).then((value) =>
          Fluttertoast.showToast(msg: "Password copied to clipboard ..."));
    } else {
      Get.snackbar("Error", response.body.toString());

      throw Exception("Failed to load data");
    }
  }
}
