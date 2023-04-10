import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../network/get_connect.dart';
import '../../dashboard/model/user_password_info_model.dart';

class UserPasswordInfoController extends GetxController {
  late PostsProvider _provider;
  RxList<UserPasswordInfoModel> userPassList = <UserPasswordInfoModel>[].obs;
  RxBool isLoading = true.obs;
  late var userId;
  @override
  void onInit() {
    _provider = PostsProvider();
    userId = Get.arguments;
    getPassInfo();
    super.onInit();
  }

  getPassInfo() async {
    isLoading(false);
    var response = await _provider.getCall("/onlyuserpassword/t/$userId");
    if (kDebugMode) {
      print("Get pass info  ");
      print(response.body);
    }
    if (!response.status.hasError) {
      if (response.body.length > 0) {
        response.body.forEach((e) {
          userPassList.add(UserPasswordInfoModel.fromJson(e));
        });
      }
    }
    isLoading(true);
  }
}
