import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/app/controllers/data_bindings.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white
        ),
        focusColor: Colors.white,
        errorColor: Colors.red,
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.cyan[200],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red[300],
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.red[300],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        iconTheme: ThemeData.light().iconTheme.copyWith(color: Colors.white),
        // primarySwatch: Colors.blue,
      ),
      initialBinding: DataBindings(),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
