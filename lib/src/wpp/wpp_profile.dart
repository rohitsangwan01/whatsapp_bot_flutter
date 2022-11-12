import 'dart:convert';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';

class WppProfile {
  WpClientInterface wpClient;
  WppProfile(this.wpClient);

  /// Get your current text status
  Future getMyStatus() async {
    return await wpClient.evaluateJs(
      '''WPP.profile.getMyStatus();''',
      methodName: "getMyStatus",
    );
  }

  /// Update your current text status
  Future setMyStatus({required String status}) async {
    return await wpClient.evaluateJs(
      '''WPP.profile.setMyStatus(${status.jsParse});''',
      methodName: "setMyStatus",
    );
  }

  /// Update your profile picture
  Future setMyProfilePicture({
    required List<int> imageBytes,
  }) async {
    String base64Image = base64Encode(imageBytes);
    String imageData = 'data:image/jpeg;base64,$base64Image';
    return await wpClient.evaluateJs(
      '''WPP.profile.setMyProfilePicture("$imageData");''',
      methodName: "getMyStatus",
    );
  }

  /// Return the current logged user is Business or not
  Future<bool> isBusiness() async {
    return await wpClient.evaluateJs(
      '''WPP.profile.isBusiness();''',
      methodName: "isBusiness",
    );
  }
}
