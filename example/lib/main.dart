import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_bot_example/home_controller.dart';
import 'package:whatsapp_bot_example/home_view.dart';

void main() {
  Get.lazyPut(() => HomeController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Whatsapp Bot",
      theme: FlexThemeData.light(
        scheme: FlexScheme.dellGenoa,
        useMaterial3: true,
        appBarElevation: 15,
      ),
      home: const HomeView(),
    ),
  );
}
