import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

import 'local_storage.dart';

// Make sure to run in terminal using
// dart main.dart ...
void main(List<String> args) async {
  print("Trying Connecting ...");
  WhatsappBotUtils.enableLogs(true);
  WhatsappLogger.handleLogs = (log) => print("WhatsappBotFlutter : $log");
  LocalStorage localStorage = LocalStorage();
  await localStorage.init(resetData: false);
  //To close previous browser instance, if we restart or hot reload
  await localStorage.closePreviousBrowserInstance();

  WhatsappClient? client = await WhatsappBotFlutter.connect(
    sessionDirectory: "../cache",
    chromiumDownloadDirectory: "../.local-chromium",
    // To connect to browser on hot reload
    // browserWsEndpoint: localStorage.wsEndPoint,
    headless: false,
    onConnectionEvent: (ConnectionEvent event) {
      print(event.toString());
    },
    onQrCode: (String qr, Uint8List? imageBytes) {
      String qrText = WhatsappBotUtils.convertStringToQrCode(qr);
      print(qrText);
    },
    onBrowserCreated: (browser) {
      localStorage.pid = browser.process?.pid;
      localStorage.wsEndPoint = browser.wsEndpoint;
      stopChromeOnPageClose(browser, localStorage);
    },
  );

  var userId = await client?.conn.getMyUserId();
  print("My User Id : $userId");

  // subscribe to Message Events
  client?.on(WhatsappEvent.chat_new_message, (data) {
    try {
      Message message = Message.fromJson(data);
      bool? fromMe = message.id?.fromMe;
      if (fromMe == false) onNewMessage(client, message);
    } catch (e) {
      print(e);
    }
  });
}

void onNewMessage(WhatsappClient client, Message message) async {
  print("Message Event : ${message.toJson()}");
  try {
    // String msg = message.body;
    String type = message.type;
    bool isFileMessage = type == "image" || type == "video" || type == "ptt";
    // Download File Message
    if (isFileMessage) {
      var base64Data = await client.chat.downloadMedia(messageId: message.id!);
      String? base64String = base64Data?['base64'] as String?;
      String? base64MimeType = base64Data?['data'] as String?;
      if (base64String == null || base64MimeType == null) return;
      String fileName = "${message.id?.id}.${base64MimeType.split("/").last}";
      File file = File(fileName);
      file.writeAsBytesSync(base64Decode(base64String));
    }
    // Reply to Message
    else {
      client.chat.sendTextMessage(
        phone: message.from,
        message: "Hey !",
        replyMessageId: message.id,
      );
    }
  } catch (e) {
    print(e);
  }
}

// Stop chromium when page is closed
void stopChromeOnPageClose(Browser browser, LocalStorage localStorage) async {
  try {
    List<Page> pages = await browser.pages;
    if (pages.length < 1) await Future.delayed(const Duration(seconds: 2));
    Page page = pages.first;
    await page.onClose;
    print("Page Closed");
    await browser.close();
    localStorage.pid = null;
    localStorage.wsEndPoint = null;
  } catch (_) {}
}
