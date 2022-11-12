import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';

class WppAuth {
  WpClientInterface wpClient;
  WppAuth(this.wpClient);

  /// check if User is Authenticated on current opened Page
  Future<bool> isAuthenticated() async {
    try {
      return await wpClient.evaluateJs('''WPP.conn.isAuthenticated();''');
    } catch (e) {
      WhatsappLogger.log(e.toString());
      return false;
    }
  }

  /// to check if ChatScreen is loaded on the page
  Future<bool> isMainReady() async {
    try {
      return await wpClient.evaluateJs('''WPP.conn.isMainReady();''');
    } catch (e) {
      WhatsappLogger.log(e.toString());
      return false;
    }
  }

  /// To Logout
  Future logout() async {
    try {
      await wpClient.evaluateJs('''WPP.conn.logout();''');
    } catch (e) {
      throw "Logout Failed";
    }
  }
}
