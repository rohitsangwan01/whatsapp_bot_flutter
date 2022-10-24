import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:zxing2/qrcode.dart';

void main(List<String> args) async {
  print("Trying Connecting ...");

  // subscribe to connection events
  WhatsappBotFlutter.connectionEventStream.listen((event) {
    print("ConnectionEvent : $event");
  });

  // Connect with Whatsapp First
  await WhatsappBotFlutter.connect(
    onSuccess: () {
      print("Connected Successfully");
    },
    onQrCode: (String qr) {
      print(qr);
      printQrCodeInTerminal(qr);
    },
    onError: (String er) {
      print(er);
    },
    progress: (int prg) {
      // we can print progress here
      print("Progress : $prg");
    },
  );

  // subscribe to Message Events
  WhatsappBotFlutter.messageEvents.listen((Message message) {
    if (!(message.id?.fromMe ?? true)) {
      print(message.toJson().toString());
    }
  });
}

// TODO : Fix qrCode printing in Terminal
void printQrCodeInTerminal(String text) {
  var qrcode = Encoder.encode(text, ErrorCorrectionLevel.l);
  var matrix = qrcode.matrix!;
  var stringBuffer = StringBuffer();

  // We go though two lines at a time!
  for (var y = 0; y < matrix.height; y += 2) {
    for (var x = 0; x < matrix.width; x++) {
      final y1 = matrix.get(x, y) == 1;
      final y2 = (y + 1 < matrix.height) ? matrix.get(x, y + 1) == 1 : false;

      if (y1 && y2) {
        stringBuffer.write('█');
      } else if (y1) {
        stringBuffer.write('▀');
      } else if (y2) {
        stringBuffer.write('▄');
      } else {
        stringBuffer.write(' ');
      }
    }
    stringBuffer.writeln();
  }
  print("\n\n");
  print('\x1B[30m$stringBuffer\x1B[30m');
  print("\n\n");
}
