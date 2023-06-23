import 'dart:typed_data';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

void main(List<String> args) async {
  WhatsappBotUtils.enableLogs(true);

  WhatsappClient? client = await WhatsappBotFlutter.connect(
    onConnectionEvent: (ConnectionEvent event) {
      print(event.toString());
    },
    onQrCode: (String qr, Uint8List? imageBytes) {
      String qrText = WhatsappBotUtils.convertStringToQrCode(qr);
      print(qrText);
    },
  );

  // subscribe to connection events
  client?.connectionEventStream.listen((event) {
    print("ConnectionEvent : $event");
  });

  // subscribe to Message Events
  client?.messageEvents.listen((Message message) {
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
  });

  // subscribe to call events
  client?.callEvents.listen((CallEvent callEvent) {
    print(callEvent.toJson());
  });
}
