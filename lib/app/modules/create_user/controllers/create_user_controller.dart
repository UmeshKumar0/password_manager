import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../network/get_connect.dart';
import '../../../routes/app_pages.dart';

class CreateUserController extends GetxController {
  final Rxn<int> selected = Rxn<int>();
  var width = Get.width;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late PostsProvider _provider;
  RxBool isLoading = false.obs;
  RxBool createAdmin = false.obs;
  final locale = GetStorage();

  @override
  void onInit() {
    _provider = PostsProvider();

    super.onInit();
  }

  createUser() async {
    isLoading(true);

    var response = await _provider.postCall("/register", {
      "name": nameController.text,
      "email": emailController.text,
      "phnNumber": phoneController.text,
      "password": passwordController.text,
      "admin": createAdmin.value
    });
    if (!response.status.hasError) {
      cleanController();

      Fluttertoast.showToast(msg: "User Created ...");

      Get.offAndToNamed(Routes.DASHBOARD);
    } else {
      if(response.body!=null){
        Get.snackbar("Error", response.body.toString());
      }else{
        Get.snackbar("Error", "Something went wrong");
      }
      

      throw Exception("Failed to load data");
    }
    isLoading(false);
  }

  cleanController() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    createAdmin.value = false;
    selected.value = null;
  }
}
