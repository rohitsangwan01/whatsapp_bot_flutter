import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/login_helper.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/qr_code_image.dart';
import 'package:whatsapp_bot_flutter/src/whatsapp_client.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp.dart';

/// [WhatsappBotFlutter] for maintaining a single  `Browser` and `Page` instance
/// with methods like connect and send
class WhatsappBotFlutter {
  /// [connect] method will open WhatsappWeb in headless webView and connect to the whatsapp
  /// and pass QrCode in `onQrCode` callback
  /// Scan this code , and on successful connection we will get onSuccessCallback
  /// We will get a WhatsappClient from here ,and we can use this client to work with whatsapp
  /// can throw Errors
  static Future<WhatsappClient?> connect({
    String? sessionDirectory,
    String? chromiumDownloadDirectory,
    bool? headless = true,
    String? browserWsEndpoint,
    int qrCodeWaitDurationSeconds = 60,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    Duration? connectionTimeout = const Duration(seconds: 20),
  }) async {
    Browser? browser;
    Page? page;
    try {
      if (browserWsEndpoint != null) {
        browser = await puppeteer.connect(
          browserWsEndpoint: browserWsEndpoint,
        );
      } else {
        RevisionInfo revisionInfo = await downloadChrome(
          cachePath: chromiumDownloadDirectory ?? "./.local-chromium",
        );
        String executablePath = revisionInfo.executablePath;
        browser = await puppeteer.launch(
          headless: headless,
          executablePath: executablePath,
          noSandboxFlag: true,
          args: ['--start-maximized', '--disable-setuid-sandbox'],
          userDataDir: sessionDirectory,
        );
      }

      page = await browser.newPage();

      await page.setUserAgent(WhatsAppMetadata.userAgent);
      await page.goto(WhatsAppMetadata.whatsAppURL);

      await Wpp(page).init();

      page.onConsole.listen(
        (event) {
          WhatsappLogger.log(event);
        },
      );

      await waitForLogin(
        page,
        (QrCodeImage qrCodeImage, int attempt) {
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
        waitDurationSeconds: qrCodeWaitDurationSeconds,
      );

      return WhatsappClient(page: page, browser: browser);
    } catch (e) {
      WhatsappLogger.log(e.toString());
      browser?.close();
      rethrow;
    }
  }

  /// To print logs from this library
  /// set `enableLogs(true)`
  /// by default its false
  static enableLogs(bool enable) {
    WhatsappLogger.enableLogger = enable;
  }
}
