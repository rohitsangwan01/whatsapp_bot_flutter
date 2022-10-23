// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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
  Rx<ConnectionEvent?> connectionEvent = Rxn<ConnectionEvent>();

  @override
  void onInit() {
    countryCode.text = "91";
    phoneNumber.text = "";
    message.text = "Testing Whatsapp Bot";

    connectionEvent.bindStream(WhatsappBotFlutter.connectionEventStream);

    WhatsappBotFlutter.messageEvents.listen((Message message) {
      if (!(message.id?.fromMe ?? true)) {
        Get.log(message.toJson().toString());
      }
    });
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

  void disconnect() async {
    await WhatsappBotFlutter.disconnect();
    connected.value = false;
  }

  void sendMessage() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await WhatsappBotFlutter.sendTextMessage(
        countryCode: countryCode.text,
        phone: phoneNumber.text,
        message: message.text,
      );
    } catch (e) {
      Get.log("Error : $e");
    }
  }

  void sendImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    String? path = result?.files.first.path;
    await sendFileMessage(path, WhatsappFileType.image);
  }

  void sendDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    String? path = result?.files.first.path;
    await sendFileMessage(path, WhatsappFileType.document);
  }

  void sendAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    String? path = result?.files.first.path;
    await sendFileMessage(path, WhatsappFileType.audio);
  }

  Future<void> sendFileMessage(
    String? filePath,
    WhatsappFileType fileType,
  ) async {
    if (!formKey.currentState!.validate()) return;
    try {
      if (filePath == null) return;
      File file = File(filePath);
      Uint8List imageBytes = Uint8List.fromList(file.readAsBytesSync());
      await WhatsappBotFlutter.sendFileMessage(
        countryCode: countryCode.text,
        phone: phoneNumber.text,
        fileBytes: imageBytes,
        caption: message.text,
        fileType: fileType,
      );
    } catch (e) {
      Get.log("Error : $e");
    }
  }
}
