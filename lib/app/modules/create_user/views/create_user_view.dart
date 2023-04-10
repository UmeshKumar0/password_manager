import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../common/navigation_drawer.dart';
import '../controllers/create_user_controller.dart';

class CreateUserView extends GetView<CreateUserController> {
  GlobalKey<FormState> formKeyCreate = GlobalKey<FormState>();

  CreateUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('CreateUserView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Container(
          color: Colors.red[100],
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKeyCreate,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Please fill this field";
                        }
                      }
                    },
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      label: RichText(
                          text: const TextSpan(
                              text: "Name ",
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ])),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[a-zA-Z]")),
                    ],
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Please fill this field";
                        } else if (value.length < 10) {
                          return "Invalid mobile number";
                        }
                      }
                    },
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      label: RichText(
                          text: const TextSpan(
                              text: "Phone Number ",
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ])),
                    ),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Please fill this field";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "not a valid email";
                        }
                      }
                    },
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      label: RichText(
                          text: const TextSpan(
                              text: "Email ",
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ])),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Please fill this field";
                        }
                      }
                    },
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      label: RichText(
                          text: const TextSpan(
                              text: "Password ",
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ])),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Want to make this user admin'),
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: controller.selected.value == 2,
                    onChanged: (val) {
                      val ?? false
                          ? {
                              controller.selected.value = 2,
                              controller.createAdmin.value = true,
                            }
                          : {
                              controller.selected.value = null,
                              controller.createAdmin.value = false,
                            };
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKeyCreate.currentState!.validate()) {
                          controller.createUser();
                        } else {
                          Get.snackbar(
                              'Please fill required fields with correct data',
                              '',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      child: const Text("Create"))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
