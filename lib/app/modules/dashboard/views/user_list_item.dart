import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';
import '../model/get_all_user_model.dart';

class UserItem extends StatefulWidget {
  UserItem({
    super.key,
    required this.user,
  });
  GetAllUserModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool showPassword = false;
  final dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
                  Icon(
                    Icons.verified,
                    color: widget.user.verified ?? false
                        ? Colors.green
                        : Colors.grey,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.more_vert),
                      items: Constants.choices.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        dashboardController.choiceAction(value ?? "",
                            data: widget.user);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text("${widget.user.email}",
                          style: const TextStyle(fontSize: 15))),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.user.isAdmin ?? false
                                  ? Colors.green
                                  : Colors.grey),
                          onPressed: () {
                            Get.defaultDialog(
                                    title: widget.user.isAdmin ?? false
                                        ? "Set User"
                                        : "Set Admin",
                                    content: Column(
                                      children: [
                                        Text(
                                            widget.user.isAdmin ?? false
                                                ? "Really want to set this admin as user ?"
                                                : "Really want to set this user as admin ?",
                                            style:
                                                const TextStyle(fontSize: 15)),
                                        ElevatedButton(
                                            onPressed: () {
                                              dashboardController.changeToAdmin(
                                                  widget.user.sId ?? "",
                                                  widget.user.isAdmin ?? false
                                                      ? false
                                                      : true);
                                            },
                                            child: const Text("Set")),
                                      ],
                                    ))
                                .then((value) =>
                                    dashboardController.getAllUsers());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                  widget.user.isAdmin ?? false
                                      ? "Admin"
                                      : "User",
                                  style: const TextStyle(fontSize: 24)))))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "User Passwords",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  showPassword
                      ? const Expanded(child: Text("data"))
                      : Container(),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.USER_PASSWORD_INFO,
                              arguments: widget.user.sId);
                        },
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(widget.user.name.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              Text(widget.user.phnNumber.toString(),
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        )
      ],
    );
  }
}
