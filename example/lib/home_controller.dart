// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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

  WhatsappClient? client;
  WhatsappClient? client2;

  StreamSubscription? messagesSubscription;

  @override
  void onInit() {
    WhatsappBotFlutter.enableLogs(true);

    countryCode.text = "91";
    phoneNumber.text = "";
    message.text = "Testing Whatsapp Bot";

    super.onInit();
  }

  void initConnection() async {
    error.value = "";
    connected.value = false;
    try {
      client = await WhatsappBotFlutter.connect(
        //sessionDirectory: "../cache",
        chromiumDownloadDirectory: "../.local-chromium", // change this path
        headless: true,
        onQrCode: (String qr, Uint8List? imageBytes) {
          qrCode.value = qr;
        },
      );
      connected.value = true;
      if (client != null) initStreams(client!);
    } catch (er) {
      error.value = er.toString();
    }
  }

  void initStreams(WhatsappClient client) async {
    // listen to ConnectionEvent Stream
    client.connectionEventStream.listen((event) {
      connectionEvent.value = event;
    });
    // listen to messageEventStream
    client.messageEvents.listen((Message message) {
      if (!(message.id?.fromMe ?? true)) {
        Get.log(message.body.toString());
      }
    });
  }

  void disconnect() async {
    await client?.disconnect(tryLogout: true);
    connected.value = false;
  }

  void sendMessage() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await client?.sendTextMessage(
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
      List<int> imageBytes = file.readAsBytesSync();
      await client?.sendFileMessage(
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
