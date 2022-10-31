import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';

class WppAuth {
  Page page;
  WppAuth(this.page);

  ///Check is User is Authenticated
  Future<bool> isAuthenticated() async {
    try {
      var result = await page.evaluate('''() => WPP.conn.isAuthenticated();''');
      return result;
    } catch (e) {
      WhatsappLogger.log(e.toString());
      return false;
    }
  }

  Future<bool> isMainReady() async {
    try {
      var result = await page.evaluate('''() => WPP.conn.isMainReady();''');
      return result;
    } catch (e) {
      WhatsappLogger.log(e.toString());
      return false;
    }
  }

  /// To Logout
  Future logout() async {
    try {
      return await page.evaluate('''() => WPP.conn.logout();''');
    } catch (e) {
      throw "Logout Failed";
    }
  }
}
