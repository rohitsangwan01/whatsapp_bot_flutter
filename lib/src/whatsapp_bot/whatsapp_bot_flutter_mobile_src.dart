import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:whatsapp_bot_flutter/src/clients/wpclient_mobile.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_connect.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';

import '../helper/login_helper.dart';

class WhatsappBotFlutterMobile {
  /// call [connect] to connect with Mobile
  static Future<WhatsappClient?> connect({
    bool saveSession = false,
    int qrCodeWaitDurationSeconds = 60,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    Function(ConnectionEvent)? onConnectionEvent,
    Duration? connectionTimeout = const Duration(seconds: 20),
  }) async {
    WpClientInterface? wpClient;

    try {
      onConnectionEvent?.call(ConnectionEvent.initializing);

      wpClient = await _getMobileWpClient(saveSession);

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

  // Helper methods
  /// to run webView in headless mode and connect with it
  static Future<WpClientMobile> _getMobileWpClient(bool keepSession) async {
    WebView.debugLoggingSettings.enabled = false;
    HeadlessInAppWebView headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(
          url: WebUri.uri(Uri.parse(
        WhatsAppMetadata.whatsAppURLForceDesktop,
      ))),
      onConsoleMessage: (controller, consoleMessage) {
        WhatsappLogger.log(consoleMessage.message);
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        return NavigationActionPolicy.ALLOW;
      },
      initialSettings: InAppWebViewSettings(
        preferredContentMode: UserPreferredContentMode.DESKTOP,
        userAgent: WhatsAppMetadata.userAgent,
        javaScriptEnabled: true,
        incognito: !keepSession,
        clearCache: !keepSession,
        cacheEnabled: keepSession,
      ),
    );
    await headlessWebView.run();
    Completer<InAppWebViewController> completer = Completer();
    headlessWebView.onLoadStop = (controller, url) async {
      // check if whatsapp web redirected us to the wrong mobile version of whatsapp
      if (!url.toString().contains("web.whatsapp.com")) {
        if (!completer.isCompleted) {
          completer.completeError(
            "Failed to load WhatsappWeb in Webview Mobile, please try again or clear cache of application",
          );
        }
      }
      if (!completer.isCompleted) completer.complete(controller);
    };
    headlessWebView.onReceivedError = (controller, request, error) {
      if (!completer.isCompleted) completer.completeError(error.description);
    };
    InAppWebViewController controller = await completer.future;

    return WpClientMobile(
      controller: controller,
      headlessInAppWebView: headlessWebView,
    );
  }
}
