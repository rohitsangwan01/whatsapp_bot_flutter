// Thanks to https://github.com/wppconnect-team/wa-js

import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_js_content.dart';

class Wpp {
  Page page;
  Wpp(this.page);

  /// make sure to call [init] to Initialize Wpp
  Future init() async {
    String content = wppJsContent.trim();
    await page.addScriptTag(content: content, type: "module");
    // wait for the Module to get Ready
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

    // Add listeners if required
    await WppEvents(page).init();
  }

  /// check if the given Phone number is a valid phone number
  Future<bool> isValidContact(Page page, String phoneNumber) async {
    try {
      await page.evaluate(
        '''(phone) => WPP.contact.queryExists(phone);''',
        args: [phoneNumber],
      );
      return true;
    } catch (e) {
      WhatsappLogger.log(e);
      return false;
    }
  }
}
