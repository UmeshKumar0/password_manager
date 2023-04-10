import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/app/controllers/data_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/user_passwords_controller.dart';
import '../models/get_all_pass_model.dart';

class PasswordListItem extends StatefulWidget {
  PasswordListItem({super.key, required this.pass});
  GetAllPassInfoModel pass;
  DataController dataController = DataController();
  @override
  State<PasswordListItem> createState() => _PasswordListItemState();
}

class _PasswordListItemState extends State<PasswordListItem> {
  bool showPassword = false;
  final passwordController = Get.find<UserPasswordsController>();

  void setKeys(int index, String value) {
    widget.pass.data![index].key = value;
  }

  void setValue(int index, String value) {
    widget.pass.data![index].value = value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PASSWORD_DETAILS,
          arguments: widget.pass,
        )?.then((value) => passwordController.getAllPass());
      },
      child: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Delete User",
                            content: Column(
                              children: [
                                const Text("Really want to delete user ?"),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () async {
                                        passwordController
                                            .deleteUser(widget.pass.sId ?? "");
                                      },
                                      child: const Text("Delete")),
                                )
                              ],
                            )).then((value) => passwordController.getAllPass());
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(
                        text: "Created at : ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: widget.pass.createdAt,
                          style: const TextStyle(color: Colors.grey))
                    ])),
                const SizedBox(
                  width: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Password"),
                    ),
                    Expanded(
                      child: IconButton(
                          onPressed: () => passwordController
                              .copyPasswordToClipboard(widget.pass.sId ?? ""),
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.pass.website.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
