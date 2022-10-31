import 'dart:async';

import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/qr_code_helper.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp.dart';

import '../model/qr_code_image.dart';

Future waitForLogin(
  Page page,
  Function(QrCodeImage, int)? onCatchQR, {
  int waitDurationSeconds = 60,
}) async {
  WhatsappLogger.log('Waiting page load');

  await Wpp.init(page);

  WhatsappLogger.log('Checking is logged...');

  bool authenticated = await WppAuth.isAuthenticated(page);

  if (!authenticated) {
    WhatsappLogger.log('Waiting for QRCode Scan...');

    await waitForQrCodeScan(
      page: page,
      onCatchQR: onCatchQR,
      waitDurationSeconds: waitDurationSeconds,
    );

    WhatsappLogger.log('Checking QRCode status...');

    await Future.delayed(const Duration(milliseconds: 200));

    authenticated = await WppAuth.isAuthenticated(page);

    if (authenticated) {
      await Future.delayed(const Duration(milliseconds: 200));
      WhatsappLogger.log('Checking phone is connected...');

      bool inChat = await waitForInChat(page);
      if (!inChat) {
        WhatsappLogger.log('Phone not connected');
        throw 'Phone not connected';
      }

      WhatsappLogger.log('Connected successfully');

      return true;
    } else {
      throw 'Login Failed';
    }
  } else {
    WhatsappLogger.log('Connected successfully');
  }
}

Future<bool> waitForInChat(Page page) async {
  var inChat = await WppAuth.isMainReady(page);
  if (inChat) return true;
  Completer<bool> completer = Completer();
  late Timer timer;
  timer = Timer.periodic(const Duration(milliseconds: 1000), (tim) async {
    if (tim.tick > 60) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete(false);
    } else {
      bool inChat = await WppAuth.isMainReady(page);
      if (inChat && !completer.isCompleted) {
        timer.cancel();
        completer.complete(true);
      }
    }
  });
  return completer.future;
}
