import 'dart:async';
import 'dart:typed_data';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/wpclient_desktop.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

/// [WhatsappBotFlutter] for maintaining a single  `Browser` and `Page` instance
/// with methods like connect and send
class WhatsappBotFlutter {
  /// [connect] method will open WhatsappWeb in headless webView and connect to the whatsapp
  /// we can manually pass `wppJsContent` to use custom wppConnect.js for connecting to whatsapp ( specially for web )
  /// we can download this file from here : `https://github.com/wppconnect-team/wa-js/releases/latest/download/wppconnect-wa.js`
  /// and pass QrCode in `onQrCode` callback
  /// Scan this code , and on successful connection we will get onSuccessCallback
  /// We will get a WhatsappClient from here ,and we can use this client to work with whatsapp
  /// can throw Errors
  static Future<WhatsappClient?> connect({
    String? sessionDirectory,
    String? wppJsContent,
    String? chromiumDownloadDirectory,
    bool? headless = true,
    String? browserWsEndpoint,
    int qrCodeWaitDurationSeconds = 60,
    List<String>? puppeteerArgs,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    Function(ConnectionEvent)? onConnectionEvent,
    Duration? connectionTimeout = const Duration(seconds: 20),
    Function(Browser browser)? onBrowserCreated,
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
        onBrowserCreated?.call(browser);
      }
      onConnectionEvent?.call(ConnectionEvent.connectingWhatsapp);
      page = await browser.newPage();
      await page.setUserAgent(WhatsAppMetadata.userAgent);
      await page.goto(WhatsAppMetadata.whatsAppURL);

      wpClient = WpClientDesktop(page: page, browser: browser);

      await WppConnect.init(
        wpClient,
        wppJsContent: wppJsContent,
      );

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
}
