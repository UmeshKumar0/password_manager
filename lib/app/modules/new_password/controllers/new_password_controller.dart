import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../network/get_connect.dart';
import '../model/key_value_model.dart';

class NewPasswordController extends GetxController {
  var keyTECs = <TextEditingController>[];
  var valueTECs = <TextEditingController>[];
  late PostsProvider _provider;

  TextEditingController websiteController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var cards = <Card>[].obs;

  @override
  void onInit() {
    _provider = PostsProvider();
    super.onInit();
  }

  onDone() async {
    List<PersonEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var name = keyTECs[i].text;
      var age = valueTECs[i].text;
      entries.add(PersonEntry(name, age));
    }
    Map<String, dynamic> body = {
      "website": websiteController.text,
      "password": passwordController.text,
      "data": [...entries.map((element) => element.toJson())],
    };

    var response = await _provider.postCall("/password", body);

    if (!response.status.hasError) {
      Get.back();
      Fluttertoast.showToast(msg: "Password Created ...");
    } else {
      Get.snackbar("Error", response.body.toString());

      throw Exception("Failed to create password");
    }
  }
}
