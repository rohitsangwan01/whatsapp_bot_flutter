import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/wp_client.dart';

class WppContact {
  WpClient wpClient;
  WppContact(this.wpClient);

  /// get ProfilePictureUrl of any Number
  Future getProfilePictureUrl({
    required String phone,
  }) async {
    return await _executeMethod(
      '''WPP.contact.getProfilePictureUrl("${parsePhone(phone)}");''',
    );
  }

  /// Get the current text status of contact
  Future getStatus({
    required String phone,
  }) async {
    return await _executeMethod(
      '''WPP.contact.getStatus("${parsePhone(phone)}");''',
    );
  }

  /// Return to list of contacts
  Future getContacts() async {
    return await _executeMethod('''WPP.contact.list();''',
        methodName: "getContacts");
  }

// common method to execute a task
  Future _executeMethod(
    String method, {
    String methodName = "",
  }) =>
      wpClient.evaluateJs(method, methodName: method);
}
