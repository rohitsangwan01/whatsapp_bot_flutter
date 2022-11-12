// ignore_for_file: empty_catches

import 'dart:async';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/qr_code_image.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';

///[qrCodeImage] will give us a Stream of QrCode
/// call init method with page
Future<void> waitForQrCodeScan({
  required WpClientInterface wpClient,
  int waitDurationSeconds = 60,
  Function(QrCodeImage, int)? onCatchQR,
}) async {
  String? urlCode;
  int attempt = 0;
  Completer completer = Completer();
  bool closeLoop = false;

  Timer timer = Timer(Duration(seconds: waitDurationSeconds), () async {
    if (!completer.isCompleted) completer.complete();
    closeLoop = true;
  });

  while (true) {
    if (closeLoop) break;
    bool connected = await WppAuth(wpClient).isAuthenticated();
    if (connected) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete();
      break;
    }

    QrCodeImage? result = await wpClient.getQrCode();
    String? code = result?.urlCode;

    if (result != null && code != null && code != urlCode) {
      urlCode = code;
      attempt++;
      WhatsappLogger.log('Waiting for QRCode Scan: Attempt $attempt');
      onCatchQR?.call(result, attempt);
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  await completer.future;
}
