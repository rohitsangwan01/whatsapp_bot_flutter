// Thanks to https://github.com/wppconnect-team/wa-js

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppConnect {
  /// make sure to call [init] to Initialize Wpp
  static Future init(
    WpClientInterface wpClient, {
    String? wppJsContent,
    String? wppLibraryUrl,
    String? wppLibraryVersion,
    required Duration waitTimeOut,
  }) async {
    String latestBuildUrl =
        "https://github.com/wppconnect-team/wa-js/releases/latest/download/wppconnect-wa.js";
    if (wppLibraryUrl != null) {
      latestBuildUrl = wppLibraryUrl;
    } else if (wppLibraryVersion != null) {
      latestBuildUrl =
          "https://github.com/wppconnect-team/wa-js/releases/download/v$wppLibraryVersion/wppconnect-wa.js";
    }
    // Web not able to download from this url, either replace this with another url, or pass the wppJsContent
    String content = wppJsContent ?? await http.read(Uri.parse(latestBuildUrl));
    await wpClient.injectJs(content);

    WhatsappLogger.log("injected Wpp");

    if (!await _waitForWppReady(wpClient, waitTimeOut)) {
      throw WhatsappException(
        exceptionType: WhatsappExceptionType.failedToConnect,
        message: "Failed to initialize WPP",
      );
    }

    await wpClient.evaluateJs(
      "WPP.chat.defaultSendMessageOptions.createChat = true;",
      tryPromise: false,
    );
    await wpClient.evaluateJs(
      "WPP.conn.setKeepAlive(true);",
      tryPromise: false,
    );
    await wpClient.evaluateJs(
      "WPP.config.poweredBy = 'Whatsapp-Bot-Flutter';",
      tryPromise: false,
    );
  }

  static Future<bool> _waitForWppReady(
    WpClientInterface wpClient,
    Duration waitTimeOut,
  ) async {
    var startTime = DateTime.now();
    while (DateTime.now().difference(startTime) < waitTimeOut) {
      await Future.delayed(const Duration(seconds: 1));
      var result = await wpClient.evaluateJs(
        '''typeof window.WPP !== 'undefined' && window.WPP.isReady;''',
        tryPromise: false,
      );
      if (result == true) return true;
      WhatsappLogger.log("Checking WPP, Retrying..");
    }
    return false;
  }
}
