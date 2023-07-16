import 'dart:convert';

import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';
import 'package:whatsapp_bot_flutter_web/src/bot_js.dart' as bot_js;

/// Desktop client for connecting to whatsapp and perform tasks
class WpClientWeb implements WpClientInterface {
  String tabId;
  WpClientWeb({required this.tabId});
  bool _isConnected = false;

  @override
  Future<void> dispose() async {
    await bot_js.dispose();
  }

  @override
  Future evaluateJs(
    String source, {
    String? methodName,
    bool tryPromise = true,
    bool forceJsonParseResult = false,
  }) async {
    String js = source;
    js = source.replaceAll(";", "");
    var result = await bot_js.evaluateJsCodeWithPromise(js, tryPromise);
    if (result != null && result is String) {
      // Try to parse boolean
      if (result == "true" || result == "false") {
        result = result == "true";
      }
      // Try to parse int
      else if (int.tryParse(result) != null) {
        result = int.parse(result);
      }
      // Try to parse double
      else if (double.tryParse(result) != null) {
        result = double.parse(result);
      }
      // Try to parse json
      else {
        result = jsonDecode(result);
      }
    }
    if (methodName?.isNotEmpty == true) {
      WhatsappLogger.log(
          "${methodName}_Result (${result.runtimeType}) : $result");
    }
    return result;
  }

  @override
  Future<QrCodeImage?> getQrCode() async {
    try {
      var result = await evaluateJs(
        '''
          function getQr()  {
            try{
              const selectorImg = document.querySelector('canvas');
              const selectorUrl = selectorImg.closest('[data-ref]');
              if (selectorImg != null && selectorUrl != null) {
                let data = {
                  base64Image: selectorImg.toDataURL(),
                  urlCode: selectorUrl.getAttribute('data-ref'),
                };
                return data;
              }
            }catch(e){
              return null;
            }
          }
          getQr();
        ''',
        tryPromise: false,
      );
      String? urlCode = result?['urlCode'];
      String? base64Image = result?['base64Image'];
      return QrCodeImage(base64Image: base64Image, urlCode: urlCode);
    } catch (e) {
      //WhatsappLogger.log("QrCodeFetchingError: $e");
      return null;
    }
  }

  @override
  Future<void> on(String event, Function(dynamic) callback) async {
    bot_js.setEvent(event, bot_js.JsCallback((data) {
      if (data is String) {
        data = jsonDecode(data);
      }
      callback(data);
    }));
  }

  @override
  Future<void> off(String event) async {
    await evaluateJs('''WPP.removeAllListeners('$event')''');
  }

  @override
  Future initializeEventListener(
    OnNewEventFromListener onNewEventFromListener,
  ) async {
    try {
      bot_js.setTabConnectionListener(tabId, bot_js.JsCallback((isConnected) {
        _isConnected = isConnected == true;
        String event = _isConnected ? "connected" : "disconnected";
        onNewEventFromListener("connectionEvent", event);
      }));
      on("conn.authenticated", (_) {
        onNewEventFromListener("connectionEvent", "authenticated");
      });
      on("conn.logout", (_) {
        onNewEventFromListener("connectionEvent", "logout");
      });
      on("conn.auth_code_change", (_) {
        onNewEventFromListener("connectionEvent", "auth_code_change");
      });
      on("conn.main_loaded", (_) {
        onNewEventFromListener("connectionEvent", "main_loaded");
      });
      on("conn.main_ready", (_) {
        onNewEventFromListener("connectionEvent", "main_ready");
      });
      on("conn.require_auth", (_) {
        onNewEventFromListener("connectionEvent", "require_auth");
      });
    } catch (e) {
      // Ignore for now
      WhatsappLogger.log(e);
    }
  }

  @override
  bool isConnected() {
    return _isConnected;
  }

  @override
  Future injectJs(String content) async {}
}
