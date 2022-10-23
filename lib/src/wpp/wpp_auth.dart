// ignore_for_file: avoid_print

import 'package:puppeteer/puppeteer.dart';

class WppAuth {
  ///Check is User is Authenticated
  Future<bool> isAuthenticated(Page page) async {
    try {
      var result = await page.evaluate('''() => WPP.conn.isAuthenticated();''');
      return result;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String?> getAuthCode(Page page) async {
    try {
      var code = await page.evaluate('''() => WPP.conn.getAuthCode();''');
      return code;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<bool> isMainReady(Page page) async {
    try {
      var result = await page.evaluate('''() => WPP.conn.isMainReady();''');
      return result;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> isMainLoaded(Page page) async {
    try {
      var result = await page.evaluate('''() =>WPP.conn.isMainLoaded();''');
      return result;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future refreshQR(Page page) async {
    try {
      var result = await page.evaluate('''() => WPP.conn.refreshQR();''');
      print(result.toString());
    } catch (e) {
      print(e.toString());
      // ignore crash for now
    }
  }

  /// To Logout
  Future logout(Page page) async {
    try {
      return await page.evaluate('''() => WPP.conn.logout();''');
    } catch (e) {
      throw "Logout Failed";
    }
  }
}
