import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

// Make sure to run in terminal using
// dart main.dart ...
void main(List<String> args) async {
  print("Trying Connecting ...");
  WhatsappBotUtils.enableLogs(true);

  WhatsappClient? client = await WhatsappBotFlutter.connect(
    sessionDirectory: "../cache",
    chromiumDownloadDirectory: "../.local-chromium",
    headless: false,
    onConnectionEvent: (ConnectionEvent event) {
      print(event.toString());
    },
    onQrCode: (String qr, Uint8List? imageBytes) {
      String qrText = WhatsappBotUtils.convertStringToQrCode(qr);
      print(qrText);
    },
    onBrowserCreated: (browser) {
      print("Browser Created with pid ${browser.process?.pid}");
      browser = browser;
      stopChromOnPageClose(browser);
    },
  );

  // subscribe to connection events
  client?.connectionEventStream.listen((event) {
    print("ConnectionEvent : $event");
  });

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

  client?.on(WhatsappEvent.chat_msg_revoke, (data) {
    print("Revoking Event : $data");
  });

  client?.on(WhatsappEvent.chat_new_reaction, (data) {
    print("NewReaction Event : $data");
  });
}

void onNewMessage(WhatsappClient client, Message message) async {
  print("Message Event : ${message.toJson()}");
  try {
    String msg = message.body;
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
    } else if (msg == "hii") {
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
void stopChromOnPageClose(Browser browser) async {
  List<Page> pages = await browser.pages;
  if (pages.length < 1) {
    await Future.delayed(const Duration(seconds: 4));
  }
  print("Pages : ${pages.length}");
  Page page = pages.first;
  await page.onClose;
  print("Page Closed");
  await browser.close();
}
