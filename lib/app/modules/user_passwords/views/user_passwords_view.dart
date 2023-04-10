import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/navigation_drawer.dart';
import '../../../routes/app_pages.dart';
import '../controllers/user_passwords_controller.dart';
import 'pass_list_item.dart';

class UserPasswordsView extends GetView<UserPasswordsController> {
  const UserPasswordsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Passwords Screen'),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => controller.getAllPass(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon:
                                const Icon(Icons.search, color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            label: const Text("Search"),
                            labelStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value) => controller.runFilter(value),
                        ),
                      ),
                      controller.searchResults.isNotEmpty
                          ? GetBuilder<UserPasswordsController>(
                              builder: (controller) => ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.searchResults.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.deepPurple[400],
                                      elevation: 16,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: PasswordListItem(
                                        pass: controller.searchResults[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: SizedBox(child: Text("No Record Found")),
                            ),
                    ],
                  ),
                ),
              );
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Icon(Icons.add),
            Text(" Password"),
          ],
        ),
        onPressed: () {
          Get.toNamed(Routes.NEW_PASSWORD)!
              .then((value) => controller.getAllPass());
        },
      ),
    );
  }
}
