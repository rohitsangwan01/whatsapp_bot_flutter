// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:puppeteer/puppeteer.dart';
import '../model/whatsapp_file_type.dart';

class WppChat {
  /// To send a Text message
  Future<void> sendTextMessage(Page page, phoneNumber, message) async {
    var sendResult = await page.evaluate(
      '''() => WPP.chat.sendTextMessage("$phoneNumber", "$message");''',
    );
    print("SendResult : $sendResult");
  }

  /// To send a Location Message
  Future<void> sendLocationMessage(
    Page page,
    String phoneNumber, {
    required String lat,
    required String long,
    String? name,
    String? address,
    String? url,
  }) async {
    var sendResult = await page.evaluate(
        '''(phone,lat,long,address,name,url) => WPP.chat.sendLocationMessage(phone, {
              lat: lat,
              lng: long,
              name: name, 
              address: address,
              url: url 
            });
            ''',
        args: [phoneNumber, lat, long, address, name, url]);
    print("SendResult : $sendResult");
  }

  /// To send a File message
  Future<void> sendFileMessage(
    Page page,
    String phoneNumber,
    List<int> fileBytes,
    WhatsappFileType fileType, {
    String? caption,
    String? mimetype,
  }) async {
    String base64Image = base64Encode(fileBytes);
    String mimeType = mimetype ?? _getMimeType(fileType);
    String imgData = "data:$mimeType;base64,$base64Image";
    var sendResult = await page
        .evaluate('''(phone,imgData,caption) => WPP.chat.sendFileMessage(
        phone,imgData,
        {
          type: 'image',
          caption: caption
        });''', args: [phoneNumber, imgData, caption]);
    print("SendResult : $sendResult");
  }

  /// [_getMimeType] returns default mimeType
  String _getMimeType(WhatsappFileType fileType) {
    switch (fileType) {
      case WhatsappFileType.document:
        return "application/msword";
      case WhatsappFileType.image:
        return "image/jpeg";
      case WhatsappFileType.audio:
        return "audio/mp3";
      // case WhatsappFileType.video:
      //   return "video/mp4";
    }
  }
}
