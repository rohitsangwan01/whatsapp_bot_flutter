import 'dart:typed_data';

import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

// Make sure to run in terminal using
// dart main.dart ...
void main(List<String> args) async {
  print("Trying Connecting ...");

  // subscribe to connection events
  WhatsappClient? client = await WhatsappBotFlutter.connect(
    //sessionDirectory: "../cache",
    chromiumDownloadDirectory: "../.local-chromium", // change this path
    headless: true,
    onConnectionEvent: (ConnectionEvent event) {
      print(event.toString());
    },
    onQrCode: (String qr, Uint8List? imageBytes) {
      String qrText = WhatsappBotFlutter.convertStringToQrCode(qr);
      print(qrText);
    },
  );
  client?.connectionEventStream.listen((event) {
    print("ConnectionEvent : $event");
  });

  // subscribe to Message Events
  client?.messageEvents.listen((Message message) {
    if (!(message.id?.fromMe ?? true)) {
      print(message.body.toString());
      if (message.body == "hii") {
        client.sendTextMessage(phone: message.from, message: "Hey !");
      }
    }
  });

  client?.callEvents.listen((CallEvent callEvent) {
    print(callEvent.toJson());
  });
}
