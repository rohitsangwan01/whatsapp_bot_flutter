import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WpClientMobile implements WpClientInterface {
  InAppWebViewController? controller;
  HeadlessInAppWebView? headlessInAppWebView;

  WpClientMobile({
    required this.controller,
    required this.headlessInAppWebView,
  });

  @override
  Future injectJs(String content) async {
    await controller?.evaluateJavascript(source: content);
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> dispose() async {
    await headlessInAppWebView?.dispose();
  }

  @override
  Future evaluateJs(
    String source, {
    String? methodName,
    bool tryPromise = true,
  }) async {
    if (!tryPromise) {
      var result = await controller?.evaluateJavascript(source: source);
      if (methodName?.isNotEmpty == true) {
        WhatsappLogger.log("${methodName}_Result : $result");
      }
      return result;
    }
    final String functionBody = """  
        var result = new Promise(async function (resolve, reject) {  
          try{
            var data = await $source;
            resolve(data);
          }catch(e){
            reject(e)
          }
        });
       return await result;  
      """;
    CallAsyncJavaScriptResult? result =
        await controller?.callAsyncJavaScript(functionBody: functionBody);
    if (methodName?.isNotEmpty == true) {
      WhatsappLogger.log("${methodName}_Result : ${result?.value}");
    }
    String? error = result?.error;
    if (error != null) {
      WhatsappLogger.log("${methodName}_Result_Error : ${result?.error}");
      throw error;
    }

    return result?.value;
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
    String callbackName = "callback_${event.replaceAll(".", "_")}";
    await evaluateJs(
      """window.$callbackName = (data) => window.flutter_inappwebview.callHandler('$callbackName',data);""",
      tryPromise: false,
    );
    controller?.addJavaScriptHandler(
      handlerName: callbackName,
      callback: callback,
    );
    await controller?.evaluateJavascript(
      source: '''
            WPP.on('$event', (data) => {
              window.$callbackName(data);
            });
        ''',
    );
  }

  @override
  Future<void> off(String event) async {
    String callbackName = "callback_${event.replaceAll(".", "_")}";
    controller?.removeJavaScriptHandler(handlerName: callbackName);
    await controller?.evaluateJavascript(
      source: '''WPP.removeAllListeners('$event');''',
    );
  }

  @override
  Future initializeEventListener(
    OnNewEventFromListener onNewEventFromListener,
  ) async {
    try {
      await evaluateJs(
        """ 
          window.onCustomEvent = (eventName,data) => window.flutter_inappwebview.callHandler('onCustomEvent',{type:eventName,data:data});
         """,
        tryPromise: false,
      );

      // Add Dart side method
      controller?.addJavaScriptHandler(
          handlerName: "onCustomEvent",
          callback: (arguments) {
            var type = arguments[0]["type"];
            var data = arguments[0]["data"];
            onNewEventFromListener.call(type.toString(), data);
          });

      // Add all listeners
      await controller?.evaluateJavascript(
        source: '''function initEvents() {
            WPP.on('conn.authenticated', () => {
              window.onCustomEvent("connectionEvent","authenticated");
            });
             WPP.on('conn.logout', () => {
              window.onCustomEvent("connectionEvent","logout");
            });
            WPP.on('conn.auth_code_change', () => {
              window.onCustomEvent("connectionEvent","auth_code_change");
            });
            WPP.on('conn.main_loaded', () => {
              window.onCustomEvent("connectionEvent","main_loaded");
            });
            WPP.on('conn.main_ready', () => {
              window.onCustomEvent("connectionEvent","main_ready");
            });
            WPP.on('conn.require_auth', () => {
              window.onCustomEvent("connectionEvent","require_auth");
            });
        }
        initEvents();
        ''',
      );
    } catch (e) {
      // Ignore for now
      WhatsappLogger.log(e);
    }
  }

  @override
  bool isConnected() {
    return controller != null && (headlessInAppWebView?.isRunning() == true);
  }
}
