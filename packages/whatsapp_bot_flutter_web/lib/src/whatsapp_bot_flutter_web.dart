// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:typed_data';

import 'package:whatsapp_bot_flutter_web/src/bot_js.dart' as bot_js;
import 'package:whatsapp_bot_flutter_web/src/wpclient_web.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WhatsappBotFlutterWeb {
  /// Connect method wil open whatsapp web in a new tab and return the client
  /// make sure you scan qr code manually for now
  static Future<WhatsappClient?> connect({
    Function(ConnectionEvent)? onConnectionEvent,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    int qrCodeWaitDurationSeconds = 60,
  }) async {
    WpClientInterface? wpClient;
    try {
      onConnectionEvent?.call(ConnectionEvent.initializing);
      Completer completer = Completer();
      bot_js.connect(
        bot_js.JsCallback((data) {
          print("ConnectedToTab : $data");
        }),
        bot_js.JsCallback((data) {
          print("WebPackReady : $data");
          completer.complete(data);
        }),
      );
      var tabId = await completer.future;

      wpClient = WpClientWeb(tabId: tabId);
      await WppConnect.init(wpClient, wppJsContent: "");
      onConnectionEvent?.call(ConnectionEvent.waitingForLogin);

      await waitForLogin(
        wpClient,
        onConnectionEvent: onConnectionEvent,
        onQrCode: onQrCode,
        waitDurationSeconds: qrCodeWaitDurationSeconds,
      );

      var client = WhatsappClient(wpClient: wpClient);
      onConnectionEvent?.call(ConnectionEvent.connected);
      return client;
    } catch (e) {
      WhatsappLogger.log(e.toString());
      wpClient?.dispose();
      rethrow;
    }
  }
}
