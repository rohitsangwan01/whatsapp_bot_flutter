import 'dart:convert';

import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';

class WppProfile {
  Page page;
  WppProfile(this.page);

  /// Get your current text status
  Future getMyStatus() async {
    return await _executeMethod('''() =>WPP.profile.getMyStatus();''',
        methodName: "getMyStatus");
  }

  /// Update your current text status
  Future setMyStatus({required String status}) async {
    return await _executeMethod(
        '''(status) =>WPP.profile.setMyStatus(status);''',
        args: [status], methodName: "setMyStatus");
  }

  /// Update your profile picture
  Future setMyProfilePicture({
    required List<int> imageBytes,
  }) async {
    String base64Image = base64Encode(imageBytes);
    String imageData = 'data:image/jpeg;base64,$base64Image';
    return await _executeMethod(
        '''(imageData) =>WPP.profile.setMyProfilePicture(imageData);''',
        args: [imageData], methodName: "getMyStatus");
  }

  /// Return the current logged user is Business or not
  Future<bool> isBusiness() async {
    return await _executeMethod('''() =>WPP.profile.isBusiness();''',
        methodName: "isBusiness");
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
