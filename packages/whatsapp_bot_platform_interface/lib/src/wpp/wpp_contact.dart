import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppContact {
  WpClientInterface wpClient;
  WppContact(this.wpClient);

  /// get ProfilePictureUrl of any Number
  Future getProfilePictureUrl({
    required String phone,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.contact.getProfilePictureUrl(${phone.phoneParse});''',
      methodName: "getProfilePictureUrl",
    );
  }

  /// Get the current text status of contact
  Future getStatus({
    required String phone,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.contact.getStatus(${phone.phoneParse});''',
      methodName: "getStatus",
    );
  }

  /// Return to list of contacts
  Future getContacts() async {
    return await wpClient
        .evaluateJs('''WPP.contact.list();''', methodName: "getContacts");
  }
}
