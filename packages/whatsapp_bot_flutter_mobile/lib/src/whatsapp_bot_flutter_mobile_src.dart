import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:whatsapp_bot_flutter_mobile/src/wpclient_mobile.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

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
    HeadlessInAppWebView headlessWebView = HeadlessInAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse(WhatsAppMetadata.whatsAppURLForceDesktop)),
      onConsoleMessage: (controller, consoleMessage) {
        WhatsappLogger.log("ConsoleLog: ${consoleMessage.message}");
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        return NavigationActionPolicy.ALLOW;
      },
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          preferredContentMode: UserPreferredContentMode.DESKTOP,
          userAgent: WhatsAppMetadata.userAgent,
          javaScriptEnabled: true,
          incognito: !keepSession,
          clearCache: !keepSession,
          cacheEnabled: keepSession,
        ),
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
    headlessWebView.onLoadError = (controller, url, code, message) {
      if (!completer.isCompleted) completer.completeError(message);
    };
    InAppWebViewController controller = await completer.future;

    return WpClientMobile(
      controller: controller,
      headlessInAppWebView: headlessWebView,
    );
  }
}
