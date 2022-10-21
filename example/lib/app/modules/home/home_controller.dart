// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_bot/whatsapp_bot.dart';

class HomeController extends GetxController {
  RxString qrCode = "".obs;
  RxString error = "".obs;
  RxInt progress = 0.obs;
  RxBool connected = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void initConnection() {
    connected.value = false;
    WhatsappBot.connect(
      onQrCode: (String qr) {
        qrCode.value = qr;
      },
      onError: (String er) {
        error.value = er;
        qrCode.value = "";
      },
      onSuccess: () {
        Get.log("Connected");
        error.value = "";
        connected.value = true;
      },
      progress: (int prg) {
        progress.value = prg;
      },
    );
  }

  void sendMessage(BuildContext context) {
    // Enter Phone Numbers
    WhatsappBot.sendMessage(countryCode: "91", phone: "", message: "Message 1");
  }

  void sendMessage2(BuildContext context) {
    WhatsappBot.sendMessage(countryCode: "91", phone: "", message: "Message 2");
  }
}
