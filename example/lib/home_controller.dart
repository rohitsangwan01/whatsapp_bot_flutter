// ignore_for_file: unnecessary_overrides

import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:whatsapp_bot_flutter_mobile/whatsapp_bot_flutter_mobile.dart';

class HomeController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var message = TextEditingController();
  var phoneNumber = TextEditingController();
  var browserClientWebSocketUrl = TextEditingController();
  String? get browserEndPoint => browserClientWebSocketUrl.text.isNotEmpty
      ? browserClientWebSocketUrl.text
      : null;

  /// reactive variables from Getx
  RxString error = "".obs;
  RxBool connected = false.obs;
  Rx<ConnectionEvent?> connectionEvent = Rxn<ConnectionEvent>();
  Rx<Message?> messageEvents = Rxn<Message>();
  Rx<CallEvent?> callEvents = Rxn<CallEvent>();

  // Get whatsapp client first to perform other Tasks
  WhatsappClient? client;

  @override
  void onInit() {
    WhatsappBotUtils.enableLogs(true);
    message.text = "Testing Whatsapp Bot";
    super.onInit();
  }

  void test() async {
    // client?.group.createGroup(groupName: "Test2");
    String groupId = '120363142949888782@g.us';
    // client?.group.addParticipants(
    //     groupId: '120363142135810421@g.us', phoneNumbers: ['8529151020']);
    // client?.group.getParticipants(groupId: groupId);
    // client?.group.getAllGroups();
    client?.group
        .removeParticipants(groupId: groupId, phoneNumber: "8529151020");
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
        // getting XmlHttpRequest error on web platform , so we have to manually
        // pass the wpp.js file to the client
        String? wppJsContent =
            kIsWeb ? await rootBundle.loadString("assets/wpp.js") : null;
        // Initialize Desktop Client
        client = await WhatsappBotFlutter.connect(
          browserWsEndpoint: browserEndPoint,
          wppJsContent: wppJsContent,
          chromiumDownloadDirectory: "../.local-chromium",
          onConnectionEvent: _onConnectionEvent,
          onQrCode: _onQrCode,
        );
      }

      if (client != null) {
        connected.value = true;
        initListeners(client!);
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

  void initListeners(WhatsappClient client) async {
    // listen to ConnectionEvent Stream
    client.connectionEventStream.listen((event) {
      connectionEvent.value = event;
    });

    // listen to MessageEvents
    client.on(WhatsappEvent.chat_new_message, (data) {
      List<Message> messages = Message.parse(data);
      if (messages.isEmpty) return;
      Message message = messages.first;
      Get.log(message.toJson().toString());
      if (!(message.id?.fromMe ?? true)) {
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

    // listen to CallEvents
    client.on(WhatsappEvent.incoming_call, (data) {
      List<CallEvent> events = CallEvent.parse(data);
      if (events.isEmpty) return;
      CallEvent event = events.first;
      callEvents.value = event;
      client.chat.rejectCall(callId: event.id);
      client.chat.sendTextMessage(
        phone: event.sender,
        message: "Hey, Call rejected by whatsapp bot",
      );
    });

    client.on(WhatsappEvent.chat_msg_revoke, (data) {
      Get.log("Revoking Event : $data");
    });
  }

  Future<void> disconnect() async {
    await client?.disconnect(tryLogout: true);
    connected.value = false;
  }

  Future<void> sendMessage() async {
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

  Future<void> sendButtonMessage() async {
    if (!formKey.currentState!.validate()) return;
    try {
      await client?.chat.sendTextMessage(
        phone: phoneNumber.text,
        message: message.text,
        useTemplate: true,
        templateTitle: "test title",
        templateFooter: "Footer",
        buttons: [
          MessageButtons(
            text: "Phone number",
            buttonData: "some phone number",
            buttonType: ButtonType.phoneNumber,
          ),
          MessageButtons(
            text: "open url",
            buttonData: "https://google.com/",
            buttonType: ButtonType.url,
          ),
          MessageButtons(
            text: "Button 1",
            buttonData: "some button id",
            buttonType: ButtonType.id,
          ),
          MessageButtons(
            text: "Button 2",
            buttonData: "some button id",
            buttonType: ButtonType.id,
          ),
          MessageButtons(
            text: "Button 3",
            buttonData: "some button id",
            buttonType: ButtonType.id,
          ),
        ],
      );
    } catch (e) {
      Get.log("Error : $e");
    }
  }

  Future<void> _sendFileMessage(
    String? filePath,
    String? fileName,
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
        fileName: fileName,
      );
    } catch (e) {
      Get.log("Error : $e");
    }
  }

  void pickFileAndSend(WhatsappFileType whatsappFileType) async {
    FileType fileType = FileType.any;
    switch (whatsappFileType) {
      case WhatsappFileType.image:
        fileType = FileType.image;
        break;
      case WhatsappFileType.audio:
        fileType = FileType.audio;
        break;
      default:
        break;
    }
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);
    String? path = result?.files.first.path;
    String? name = result?.names.first;
    await _sendFileMessage(path, name, whatsappFileType);
  }
}
