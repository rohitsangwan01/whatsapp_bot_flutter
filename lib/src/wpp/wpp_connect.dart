// Thanks to https://github.com/wppconnect-team/wa-js

import 'package:http/http.dart' as http;
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';
import 'package:whatsapp_bot_flutter/src/model/whatsapp_exception.dart';

class WppConnect {
  /// make sure to call [init] to Initialize Wpp
  static Future init(
    WpClientInterface wpClient, {
    String? wppJsContent,
  }) async {
    String latestBuildUrl =
        "https://github.com/wppconnect-team/wa-js/releases/latest/download/wppconnect-wa.js";
    // Web not able to download from this url, either replace this with another url, or pass the wppJsContent
    String content = wppJsContent ?? await http.read(Uri.parse(latestBuildUrl));
    await wpClient.injectJs(content);

    WhatsappLogger.log("injected Wpp");

    var result = await wpClient.evaluateJs(
      '''typeof window.WPP !== 'undefined' && window.WPP.isReady;''',
      tryPromise: false,
    );

    if (result == false) {
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
}
