import 'dart:typed_data';
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
    },
  );

  // subscribe to connection events
  client?.connectionEventStream.listen((event) {
    print("ConnectionEvent : $event");
  });

  // subscribe to Message Events
  client?.on(WhatsappEvent.chat_new_message, (data) {
    Message message = Message.fromJson(data);
    if (!(message.id?.fromMe ?? true)) {
      print(message.body.toString());
      if (message.body == "hii") {
        client.chat.sendTextMessage(
          phone: message.from,
          message: "Hey !",
          replyMessageId: message.id,
        );
      }
    }
    print("Message Event : $data");
  });

  client?.on(WhatsappEvent.chat_msg_revoke, (data) {
    print("Revoking Event : $data");
  });

  client?.on(WhatsappEvent.chat_new_reaction, (data) {
    print("NewReaction Event : $data");
  });
}
