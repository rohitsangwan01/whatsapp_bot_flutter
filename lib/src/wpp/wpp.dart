// Thanks to https://github.com/wppconnect-team/wa-js
// ignore_for_file: unused_local_variable

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_bot_flutter/src/model/wp_client.dart';

class Wpp {
  WpClient wpClient;
  Wpp(this.wpClient);

  /// make sure to call [init] to Initialize Wpp
  Future init() async {
    String latestBuildUrl =
        "https://github.com/wppconnect-team/wa-js/releases/latest/download/wppconnect-wa.js";
    String content = await http.read(Uri.parse(latestBuildUrl));

    Page? page = wpClient.page;
    InAppWebViewController? controller = wpClient.webViewController;

    if (controller != null) {
      await _initController(controller, content);
    } else if (page != null) {
      _initPage(page, content);
    }
  }

  Future _initPage(
    Page page,
    String content,
  ) async {
    await page.addScriptTag(content: content, type: "module");
    try {
      await page.waitForFunction('''() => {
        return typeof window.WPP !== 'undefined' && window.WPP.isReady;
    } ''', timeout: const Duration(seconds: 10));
    } catch (e) {
      WhatsappLogger.log(e);
    }

    await page.evaluate(
      '''() => {
        WPP.chat.defaultSendMessageOptions.createChat = true;
        WPP.conn.setKeepAlive(true);
        WPP.config.poweredBy = 'Whatsapp-Bot-Flutter';
      }
    ''',
    );
  }

  Future _initController(
    InAppWebViewController controller,
    String content,
  ) async {
    await controller.evaluateJavascript(source: content);
    await Future.delayed(const Duration(seconds: 2));
    var result = await controller.evaluateJavascript(
      source: '''typeof window.WPP !== 'undefined' && window.WPP.isReady;''',
    );
    WhatsappLogger.log("WppReady : $result");
    if (result == false) {
      throw "Failed to initialize WPP";
    }
    await controller.evaluateJavascript(
      source: "WPP.chat.defaultSendMessageOptions.createChat = true;",
    );
    await controller.evaluateJavascript(
      source: "WPP.conn.setKeepAlive(true);",
    );
    await controller.evaluateJavascript(
      source: "WPP.config.poweredBy = 'Whatsapp-Bot-Flutter';",
    );
  }
}
