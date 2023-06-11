import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:whatsapp_bot_platform_interface/src/helper/qr_code_helper.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

/// [waitForLogin] will either complete with successful login
/// or failed with timeout exception
/// this method will automatically try to get the qrCode
/// also it will make sure that we get the latest qrCode
Future waitForLogin(
  WpClientInterface wpClient, {
  required Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
  int waitDurationSeconds = 60,
  Function(ConnectionEvent)? onConnectionEvent,
}) async {
  WhatsappLogger.log('Waiting page load');

  WhatsappLogger.log('Checking is logged...');
  WppAuth wppAuth = WppAuth(wpClient);

  bool authenticated = await wppAuth.isAuthenticated();

  if (!authenticated) {
    onConnectionEvent?.call(ConnectionEvent.waitingForQrScan);

    WhatsappLogger.log('Waiting for QRCode Scan...');

    await waitForQrCodeScan(
      wpClient: wpClient,
      onCatchQR: (QrCodeImage qrCodeImage, int attempt) {
        if (qrCodeImage.base64Image != null && qrCodeImage.urlCode != null) {
          Uint8List? imageBytes;
          try {
            String? base64Image = qrCodeImage.base64Image
                ?.replaceFirst("data:image/png;base64,", "");
            imageBytes = base64Decode(base64Image!);
          } catch (e) {
            WhatsappLogger.log(e);
          }
          onQrCode?.call(qrCodeImage.urlCode!, imageBytes);
        }
      },
      waitDurationSeconds: waitDurationSeconds,
    );

    WhatsappLogger.log('Checking QRCode status...');

    await Future.delayed(const Duration(milliseconds: 200));

    authenticated = await wppAuth.isAuthenticated();

    if (authenticated) {
      onConnectionEvent?.call(ConnectionEvent.authenticated);

      await Future.delayed(const Duration(milliseconds: 200));
      WhatsappLogger.log('Checking phone is connected...');

      onConnectionEvent?.call(ConnectionEvent.connecting);
      bool inChat = await _waitForInChat(wpClient);
      if (!inChat) {
        WhatsappLogger.log('Phone not connected');
        throw 'Phone not connected';
      }

      WhatsappLogger.log('Connected successfully');
      onConnectionEvent?.call(ConnectionEvent.connected);
    } else {
      throw 'Login Failed';
    }
  } else {
    await Future.delayed(const Duration(milliseconds: 200));
    WhatsappLogger.log('Checking phone is connected...');

    onConnectionEvent?.call(ConnectionEvent.connecting);
    bool inChat = await _waitForInChat(wpClient);
    if (!inChat) {
      WhatsappLogger.log('Phone not connected');
      throw 'Phone not connected';
    }
    WhatsappLogger.log('Connected successfully');
    onConnectionEvent?.call(ConnectionEvent.connected);
  }
}

Future<bool> _waitForInChat(WpClientInterface wpClient) async {
  var inChat = await WppAuth(wpClient).isMainReady();
  if (inChat) return true;
  Completer<bool> completer = Completer();
  late Timer timer;
  WppAuth wppAuth = WppAuth(wpClient);
  timer = Timer.periodic(const Duration(milliseconds: 1000), (tim) async {
    if (tim.tick > 60) {
      timer.cancel();
      if (!completer.isCompleted) completer.complete(false);
    } else {
      bool inChat = await wppAuth.isMainReady();
      if (inChat && !completer.isCompleted) {
        timer.cancel();
        completer.complete(true);
      }
    }
  });
  return completer.future;
}
