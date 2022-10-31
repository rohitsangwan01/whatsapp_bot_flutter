import 'dart:typed_data';

import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

// Make sure to run in terminal using
// dart main.dart ...
void main(List<String> args) async {
  print("Trying Connecting ...");

  // subscribe to connection events
  WhatsappBotFlutter.connectionEventStream.listen((event) {
    print("ConnectionEvent : $event");
  });

  // Connect with Whatsapp First
  await WhatsappBotFlutter.connect(
    chromiumDownloadDirectory: "../.local-chromium",
    onSuccess: () {
      print("Connected Successfully");
    },
    onQrCode: (String qr, Uint8List? imageBytes) {
      // print qrCode in Terminal
      String qrText = WhatsappBotFlutter.convertStringToQrCode(qr);
      print(qrText);
    },
    onError: (String er) {
      print(er);
    },
  );

  // subscribe to Message Events
  WhatsappBotFlutter.messageEvents.listen((Message message) {
    if (!(message.id?.fromMe ?? true)) {
      print(message.toJson().toString());
    }
  });
}
