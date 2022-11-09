// ignore_for_file: empty_catches

import 'dart:async';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/qr_code_image.dart';
import 'package:whatsapp_bot_flutter/src/model/wp_client.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';

///[qrCodeImage] will give us a Stream of QrCode
/// call init method with page
Future<void> waitForQrCodeScan({
  required WpClient wpClient,
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

    QrCodeImage? result = await _getQrCodeImage(wpClient);
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

//TODO ; Merge These
Future<QrCodeImage?> _getQrCodeImage(WpClient wpClient) async {
  try {
    var result;
    if (wpClient.page != null) {
      bool click = await wpClient.page?.evaluate('''() => {
      const selectorImg = document.querySelector('canvas');
      const selectorUrl = selectorImg.closest('[data-ref]');
      const buttonReload = selectorUrl.querySelector('button');
      if (buttonReload != null) {
        buttonReload.click();
        return true;
      }
      return false;
    }''') ?? false;

      if (click) {
        await wpClient.page?.waitForFunction('''() => {
      const selectorImg = document.querySelector('canvas');
      const selectorUrl = selectorImg.closest('[data-ref]');
      return selectorUrl.getAttribute('data-ref');
    }''');
      }

      result = await wpClient.page?.evaluate('''() => {
      const selectorImg = document.querySelector('canvas');
      const selectorUrl = selectorImg.closest('[data-ref]');
      if (selectorImg != null && selectorUrl != null) {
        let data = {
          base64Image: selectorImg.toDataURL(),
          urlCode: selectorUrl.getAttribute('data-ref'),
        };
        return data;
      }
    }''');
    } else {
      result = await wpClient.webViewController?.evaluateJavascript(source: '''
      function getQr()  {
            const selectorImg = document.querySelector('canvas');
            const selectorUrl = selectorImg.closest('[data-ref]');
            if (selectorImg != null && selectorUrl != null) {
              let data = {
                base64Image: selectorImg.toDataURL(),
                urlCode: selectorUrl.getAttribute('data-ref'),
              };
              return data;
            }
          }
          getQr();
    ''');
    }

    String? urlCode = result?['urlCode'];
    String? base64Image = result?['base64Image'];
    return QrCodeImage(base64Image: base64Image, urlCode: urlCode);
  } catch (e) {
    WhatsappLogger.log("QrCodeFetchingError: $e");
    return null;
  }
}
