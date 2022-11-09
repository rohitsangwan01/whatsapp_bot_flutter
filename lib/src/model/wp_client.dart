import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';

class WpClient {
  Page? page;
  InAppWebViewController? webViewController;
  HeadlessInAppWebView? headlessWebView;

  WpClient({
    this.page,
    this.webViewController,
    this.headlessWebView,
  }) {
    if (page == null && webViewController == null) {
      throw 'Page or WebViewController required';
    }
  }

  /// To execute Javascript in given Form
  Future evaluateJs(
    String method, {
    String methodName = "",
  }) async {
    //TODO : fix validate connection
    //  await validateConnection(this);

    dynamic result;

    // For Puppeteer
    if (page != null) {
      result = await page?.evaluate(method);
    }
    // For mobile webView
    else if (webViewController != null) {
      // TODO : fix : always returns empty result
      result = await webViewController?.evaluateJavascript(source: method);
    } else {
      throw "Invalid WpClient";
    }
    if (methodName.isNotEmpty) {
      WhatsappLogger.log("${methodName}_Result : $result");
    }
    return result;
  }
}
