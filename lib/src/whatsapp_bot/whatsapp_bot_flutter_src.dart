import 'dart:async';
import 'dart:typed_data';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/clients/wpclient_desktop.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_connect.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';
import 'package:zxing2/qrcode.dart';

import '../helper/login_helper.dart';

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
    List<String>? puppeteerArgs,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    Function(ConnectionEvent)? onConnectionEvent,
    Duration? connectionTimeout = const Duration(seconds: 20),
  }) async {
    WpClientInterface? wpClient;

    try {
      onConnectionEvent?.call(ConnectionEvent.initializing);

      Browser? browser;
      Page? page;

      if (browserWsEndpoint != null) {
        onConnectionEvent?.call(ConnectionEvent.connectingChrome);
        browser = await puppeteer.connect(
          browserWsEndpoint: browserWsEndpoint,
        );
      } else {
        onConnectionEvent?.call(ConnectionEvent.downloadingChrome);

        DownloadedBrowserInfo revisionInfo = await downloadChrome(
          cachePath: chromiumDownloadDirectory ?? "./.local-chromium",
        );
        String executablePath = revisionInfo.executablePath;
        onConnectionEvent?.call(ConnectionEvent.connectingChrome);
        browser = await puppeteer.launch(
          headless: headless,
          executablePath: executablePath,
          userDataDir: sessionDirectory,
          args: puppeteerArgs,
        );
      }

      page = await browser.newPage();
      await page.setUserAgent(WhatsAppMetadata.userAgent);
      await page.goto(WhatsAppMetadata.whatsAppURL);

      wpClient = WpClientDesktop(page: page, browser: browser);

      await WppConnect.init(wpClient);

      onConnectionEvent?.call(ConnectionEvent.waitingForLogin);

      await waitForLogin(
        wpClient,
        onConnectionEvent: onConnectionEvent,
        onQrCode: onQrCode,
        waitDurationSeconds: qrCodeWaitDurationSeconds,
      );

      return WhatsappClient(wpClient: wpClient);
    } catch (e) {
      WhatsappLogger.log(e.toString());
      wpClient?.dispose();
      rethrow;
    }
  }

  /// To print logs from this library
  /// set `enableLogs(true)`
  /// by default its false
  static enableLogs(bool enable) {
    WhatsappLogger.enableLogger = enable;
  }

  /// [convertStringToQrCode] will convert a Text into a qrCode , which we can print in Terminal
  /// used in scanning code from terminal if we are using this in pure Dart project
  /// make sure to run dart project in terminal , not in DebugConsole for proper Qr representation
  static String convertStringToQrCode(String text) {
    var qrcode = Encoder.encode(text, ErrorCorrectionLevel.l);
    var matrix = qrcode.matrix!;
    var stringBuffer = StringBuffer();
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
    return stringBuffer.toString();
  }
}
