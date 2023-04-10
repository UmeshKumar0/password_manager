import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.onDone();
              }
            },
            label: const Text("Create")),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('New Password'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.red[100],
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Enter this field";
                        }
                      }
                    },
                    controller: controller.websiteController,
                    decoration: InputDecoration(
                        label: RichText(
                      text: TextSpan(
                          text: "Website ",
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: Colors.red[300]))
                          ]),
                    )),
                  ),
                  TextFormField(
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Enter this field";
                        }
                      }
                    },
                    decoration: InputDecoration(
                        label: RichText(
                      text: TextSpan(
                          text: "Password ",
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: Colors.red[300]))
                          ]),
                    )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Add key value"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            controller.cards.value.add(createCard(controller));
                            controller.refresh();
                          },
                          child: const Text("Add +")),
                      ElevatedButton(
                          onPressed: () {
                            controller.cards.value.removeLast();
                            controller.keyTECs.removeLast();
                            controller.valueTECs.removeLast();
                            controller.refresh();
                          },
                          child: const Text("Delete"))
                    ],
                  ),
                  Expanded(
                    child: GetBuilder<NewPasswordController>(
                      builder: (controller) => ListView.builder(
                        itemCount: controller.cards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return controller.cards[index];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

Card createCard(NewPasswordController controller) {
  var keyController = TextEditingController();
  var valueController = TextEditingController();

  controller.keyTECs.add(keyController);
  controller.valueTECs.add(valueController);

  return Card(
    elevation: 0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Flexible(
              child: TextField(
                  controller: keyController,
                  decoration: const InputDecoration(labelText: 'Key')),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                  controller: valueController,
                  decoration: const InputDecoration(labelText: 'Value')),
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        )
      ],
    ),
  );
}
