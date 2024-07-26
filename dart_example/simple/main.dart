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
    linkWithPhoneNumber: '917988280596',
    onConnectionEvent: (ConnectionEvent event) {
      print(event.toString());
    },
    onPhoneLinkCode: (code) {
      print(code);
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
  client?.on(WhatsappEvent.chatNewMessage, (data) {
    try {
      Message message = Message.fromJson(data);
      message.from;
      bool? fromMe = message.id?.fromMe;
      if (fromMe == false) onNewMessage(client, message);
    } catch (e) {
      print(e);
    }
  });

  client?.on(WhatsappEvent.chatMsgRevoke, (data) {
    print("Revoking Event : $data");
  });

  client?.on(WhatsappEvent.chatNewReaction, (data) {
    print("NewReaction Event : $data");
  });
}

void onNewMessage(WhatsappClient client, Message message) async {
  print("Message Event : ${message.toJson()}");
  try {
    String? msg = message.body;
    if (msg == "hii") {
      client.chat.sendTextMessage(
        phone: message.from ?? '',
        message: "Hey !",
        replyMessageId: message.id,
      );
    }
  } catch (e) {
    print(e);
  }
}
