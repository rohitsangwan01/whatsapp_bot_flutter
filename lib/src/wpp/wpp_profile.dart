import 'dart:convert';
import 'package:whatsapp_bot_flutter/src/model/wp_client.dart';

class WppProfile {
  WpClient wpClient;
  WppProfile(this.wpClient);

  /// Get your current text status
  Future getMyStatus() async {
    return await _executeMethod('''() =>WPP.profile.getMyStatus();''',
        methodName: "getMyStatus");
  }

  /// Update your current text status
  Future setMyStatus({required String status}) async {
    return await _executeMethod('''WPP.profile.setMyStatus("$status");''',
        methodName: "setMyStatus");
  }

  /// Update your profile picture
  Future setMyProfilePicture({
    required List<int> imageBytes,
  }) async {
    String base64Image = base64Encode(imageBytes);
    String imageData = 'data:image/jpeg;base64,$base64Image';
    return await _executeMethod(
        '''WPP.profile.setMyProfilePicture("$imageData");''',
        methodName: "getMyStatus");
  }

  /// Return the current logged user is Business or not
  Future<bool> isBusiness() async {
    return await _executeMethod('''WPP.profile.isBusiness();''',
        methodName: "isBusiness");
  }

// common method to execute a task
  Future _executeMethod(
    String method, {
    String methodName = "",
  }) =>
      wpClient.evaluateJs(method, methodName: method);
}
