// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

class HomeController extends GetxController {
  RxString qrCode = "".obs;
  RxString error = "".obs;
  RxInt progress = 0.obs;
  RxBool connected = false.obs;

  var message = TextEditingController();
  var countryCode = TextEditingController();
  var phoneNumber = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    countryCode.text = "91";
    phoneNumber.text = "";
    message.text = "Testing Whatsapp Bot";
    super.onInit();
  }

  void initConnection() {
    connected.value = false;
    error.value = "";
    WhatsappBotFlutter.connect(
      onQrCode: (String qr) {
        qrCode.value = qr;
      },
      onError: (String er) {
        error.value = er;
        qrCode.value = "";
        progress.value = 0;
      },
      onSuccess: () {
        error.value = "";
        connected.value = true;
        qrCode.value = "";
        progress.value = 0;
      },
      progress: (int prg) {
        progress.value = prg;
      },
    );
  }

  void sendMessage() {
    if (!formKey.currentState!.validate()) return;
    WhatsappBotFlutter.sendMessage(
      countryCode: countryCode.text,
      phone: phoneNumber.text,
      message: message.text,
    );
  }
}
