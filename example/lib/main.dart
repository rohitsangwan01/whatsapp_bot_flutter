import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Whatsapp Bot",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
