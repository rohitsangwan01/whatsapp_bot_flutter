import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WpClientDesktop implements WpClientInterface {
  Page? page;
  Browser? browser;

  WpClientDesktop({required this.page, required this.browser});

  @override
  Future<void> dispose() async {
    browser?.disconnect();
  }

  @override
  Future evaluateJs(
    String source, {
    String? methodName,
    bool tryPromise = true,
  }) async {
    //  await validateConnection(this);
    dynamic result = await page?.evaluate(source);
    if (methodName?.isNotEmpty == true) {
      WhatsappLogger.log("${methodName}_Result : $result");
    }
    return result;
  }

  @override
  Future<QrCodeImage?> getQrCode() async {
    try {
      bool click = await page?.evaluate('''() => {
      const selectorImg = document.querySelector('canvas');
      const selectorUrl = selectorImg.closest('[data-ref]');
      const buttonReload = selectorUrl.querySelector('button');
      if (buttonReload != null) {
        buttonReload.click();
        return true;
      }
      return false;
    }''') ?? false;

      if (click) {
        await page?.waitForFunction('''() => {
      const selectorImg = document.querySelector('canvas');
      const selectorUrl = selectorImg.closest('[data-ref]');
      return selectorUrl.getAttribute('data-ref');
    }''');
      }

      var result = await page?.evaluate('''() => {
      const selectorImg = document.querySelector('canvas');
      const selectorUrl = selectorImg.closest('[data-ref]');
      if (selectorImg != null && selectorUrl != null) {
        let data = {
          base64Image: selectorImg.toDataURL(),
          urlCode: selectorUrl.getAttribute('data-ref'),
        };
          return data;
        }
      }''');
      String? urlCode = result?['urlCode'];
      String? base64Image = result?['base64Image'];
      return QrCodeImage(base64Image: base64Image, urlCode: urlCode);
    } catch (e) {
      //WhatsappLogger.log("QrCodeFetchingError: $e");
      return null;
    }
  }

  @override
  Future initializeEventListener(
      OnNewEventFromListener onNewEventFromListener) async {
    try {
      // Add Dart side method
      await page?.exposeFunction("onCustomEvent", (type, data) {
        onNewEventFromListener.call(type.toString(), data);
      });

      // Add all listeners
      await page?.evaluate(
        '''()=>{
            WPP.on('chat.new_message', (msg) => {
              window.onCustomEvent("messageEvent",msg);
            });
            WPP.on('call.incoming_call', (call) => {
              window.onCustomEvent("callEvent",call);
            });
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
        }''',
      );
    } catch (e) {
      // Ignore for now
      WhatsappLogger.log(e);
    }
  }

  @override
  bool isConnected() {
    return page != null && (page?.browser.isConnected == true);
  }

  @override
  Future injectJs(String content) async {
    await page?.addScriptTag(content: content, type: "module");
    try {
      await page?.waitForFunction('''() => {
          return typeof window.WPP !== 'undefined' && window.WPP.isReady;
      } ''', timeout: const Duration(seconds: 10));
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }
}
