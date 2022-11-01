import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';

class WppContact {
  Page page;
  WppContact(this.page);

  /// get ProfilePictureUrl of any Number
  Future getProfilePictureUrl({
    required String phone,
  }) async {
    return await _executeMethod(
        '''(phone) =>WPP.contact.getProfilePictureUrl(phone);''',
        args: [parsePhone(phone)], methodName: "getProfilePictureUrl");
  }

  /// Get the current text status of contact
  Future getStatus({
    required String phone,
  }) async {
    return await _executeMethod('''(phone) =>WPP.contact.getStatus(phone);''',
        args: [parsePhone(phone)], methodName: "getStatus");
  }

  /// Return to list of contacts
  Future getContacts() async {
    return await _executeMethod('''() =>WPP.contact.list();''',
        methodName: "getContacts");
  }

  // common method to execute a task
  Future _executeMethod(
    String method, {
    List<dynamic>? args,
    String methodName = "",
  }) async {
    await validateConnection(page);
    var result = await page.evaluate(method, args: args);
    WhatsappLogger.log("${methodName}Result : $result");
    return result;
  }
}
