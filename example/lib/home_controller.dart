// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter_mobile.dart';

class HomeController extends GetxController {
  RxString error = "".obs;
  RxBool connected = false.obs;

  var message = TextEditingController();
  var phoneNumber = TextEditingController();
  var browserClientWebSocketUrl = TextEditingController();

  String? get browserEndPoint => browserClientWebSocketUrl.text.isEmpty
      ? null
      : browserClientWebSocketUrl.text;

  var formKey = GlobalKey<FormState>();

  /// reactive variables from Getx
  Rx<ConnectionEvent?> connectionEvent = Rxn<ConnectionEvent>();
  Rx<Message?> messageEvents = Rxn<Message>();
  Rx<CallEvent?> callEvents = Rxn<CallEvent>();

  // Native chrome client supported only on desktop platforms
  bool supportNativeChromeClient = !GetPlatform.isWeb;

  WhatsappClient? client;

  @override
  void onInit() {
    WhatsappBotFlutter.enableLogs(true);
    phoneNumber.text = "";
    message.text = "Testing Whatsapp Bot";

    /// Enter WebSocket url here or manually using text field in Mobile/Web Platforms
    browserClientWebSocketUrl.text = "";
    super.onInit();
  }

  void initConnection() async {
    error.value = "";
    connected.value = false;
    try {
      if (!GetPlatform.isWeb && GetPlatform.isMobile) {
        // Initialize Mobile Client

        client = await WhatsappBotFlutterMobile.connect(
          saveSession: true,
          onConnectionEvent: _onConnectionEvent,
          onQrCode: _onQrCode,
        );
      } else {
        // Initialize Desktop Client
        client = await WhatsappBotFlutter.connect(
          browserWsEndpoint: browserEndPoint,
          chromiumDownloadDirectory: "../.local-chromium",
          headless: true,
          onConnectionEvent: _onConnectionEvent,
          onQrCode: _onQrCode,
        );
      }

      if (client != null) {
        connected.value = true;
        initStreams(client!);
      }
    } catch (er) {
      error.value = er.toString();
    }
  }

  void _onConnectionEvent(ConnectionEvent event) {
    connectionEvent(event);
    if (event == ConnectionEvent.connected) {
      _closeQrCodeDialog();
    }
  }

  void _onQrCode(String qr, Uint8List? imageBytes) {
    if (imageBytes != null) {
      _closeQrCodeDialog();
      _showQrCodeDialog(imageBytes);
    }
  }

  void _closeQrCodeDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  void _showQrCodeDialog(Uint8List bytes) {
    Get.defaultDialog(
      title: "Scan QrCode",
      content: Image.memory(bytes),
      onCancel: () {},
    );
  }

  void initStreams(WhatsappClient client) async {
    // listen to ConnectionEvent Stream
    client.connectionEventStream.listen((event) {
      connectionEvent.value = event;
    });
    // listen to CallEvent Stream
    client.callEvents.listen((event) {
      callEvents.value = event;
      client.chat.rejectCall(callId: event.id);
      client.chat.sendTextMessage(
        phone: event.sender,
        message: "Hey, Call rejected by whatsapp bot",
      );
    });
    // listen to messageEventStream
    client.messageEvents.listen((Message message) {
      if (!(message.id?.fromMe ?? true)) {
        Get.log(message.toJson().toString());
        messageEvents.value = message;

        // auto reply if message == test
        if (message.body == "test") {
          client.chat.sendTextMessage(
            phone: message.from,
            message: "Hey !",
            replyMessageId: message.id,
          );
        }
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
      await client?.chat.sendTextMessage(
        phone: phoneNumber.text,
        message: message.text,
      );
    } catch (e) {
      Get.log("Error : $e");
    }
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

      await client?.chat.sendFileMessage(
        phone: phoneNumber.text,
        fileBytes: imageBytes,
        caption: message.text,
        fileType: fileType,
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
}
