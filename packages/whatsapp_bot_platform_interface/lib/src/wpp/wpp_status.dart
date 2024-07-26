import 'dart:convert';

import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

// https://wppconnect.io/wa-js/modules/status.html
class WppStatus {
  WpClientInterface wpClient;
  WppStatus(this.wpClient);

  /// Get the current text status of contact
  Future getStatus({
    required String phone,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.status.get(${phone.phoneParse});''',
      forceJsonParseResult: true,
      methodName: "get",
    );
  }

  /// Get your current status
  Future getMyStatus() async {
    return await wpClient.evaluateJs(
      '''WPP.status.getMyStatus();''',
      forceJsonParseResult: true,
      methodName: "getMyStatus",
    );
  }

  /// remove your status
  Future remove({required String statusId}) async {
    return await wpClient.evaluateJs(
      '''WPP.status.remove(${statusId.jsParse});''',
      methodName: "remove",
    );
  }

  /// Send Text Status
  Future sendTextStatus({
    required String text,
    String backgroundColor = '#0275d8',
    int font = 2,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.status.sendTextStatus(${text.jsParse}, { backgroundColor: ${backgroundColor.jsParse}, font: ${font.jsParse}});''',
      methodName: "sendTextStatus",
    );
  }

  /// Send image Status
  Future sendImageStatus({
    required List<int> fileBytes,
    String? mime,
  }) async {
    String base64Image = base64Encode(fileBytes);
    String mimeType = mime ?? 'image/jpeg';
    String fileData = "data:$mimeType;base64,$base64Image";
    return await wpClient.evaluateJs(
      '''WPP.status.sendImageStatus(${fileData.jsParse});''',
      methodName: "sendImageStatus",
    );
  }

  /// Send Video Status
  Future sendVideoStatus({
    required List<int> fileBytes,
    String? mime,
  }) async {
    String base64Image = base64Encode(fileBytes);
    String mimeType = mime ?? 'video/mp4';
    String fileData = "data:$mimeType;base64,$base64Image";
    return await wpClient.evaluateJs(
      '''WPP.status.sendVideoStatus(${fileData.jsParse});''',
      methodName: "sendVideoStatus",
    );
  }
}
