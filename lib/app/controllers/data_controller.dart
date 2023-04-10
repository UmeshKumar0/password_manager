import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/dashboard/model/get_all_user_model.dart';
import '../modules/dashboard/model/get_user_info_model.dart';

class DataController extends GetxController {
  List<GetAllUserModel> allUsers = [];
  Rx<GetUserInfoModel> user = GetUserInfoModel().obs;
  GetStorage getStorage = GetStorage();

  getUser() async {
    final data = await getStorage.read("user");
    GetUserInfoModel userData = GetUserInfoModel.fromJson(json.decode(data));
    user.value = userData;
  }

  setUser({required GetUserInfoModel user}) {
    this.user.value = user;
  }

  setAllUserModel({required List<GetAllUserModel> user}) {
    allUsers = user;
  }
}
