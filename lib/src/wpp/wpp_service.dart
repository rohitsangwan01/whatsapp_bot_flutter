// Thanks to https://github.com/wppconnect-team/wa-js
// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';

class Wpp {
  /// make sure to call [init] to Initialize Wpp
  Future init(Page page) async {
    // add js file from Assets
    String wppPath = "packages/whatsapp_bot_flutter/assets/wpp.js";
    String content = await rootBundle.loadString(wppPath);
    await page.addScriptTag(content: content, type: "module");
    // wait for the Module to get Ready
    await isReady(page);
    await page.evaluate(
      '''() => {
        WPP.chat.defaultSendMessageOptions.createChat = true;
        WPP.conn.setKeepAlive(true);
        WPP.config.poweredBy = 'Whatsapp-Bot-Flutter';
      }
    ''',
    );

    // Add listeners if required
    WppEvents.addEventListeners(page);

    print("Wpp Initialized");
  }

  /// call [isReady] to check if `Wpp` js Loaded Successfully
  Future<bool> isReady(Page page) async {
    try {
      await page.waitForFunction('''() => {
        return typeof window.WPP !== 'undefined' && window.WPP.isReady;
    } ''', timeout: const Duration(seconds: 6));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// check if the given Phone number is a valid phone number
  Future<bool> isValidContact(Page page, String phoneNumber) async {
    try {
      await page.evaluate(
        '''() => WPP.contact.queryExists('$phoneNumber');''',
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
