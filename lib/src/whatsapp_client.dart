import 'dart:async';
import 'dart:convert';

import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'package:whatsapp_bot_flutter/src/model/whatsapp_exception.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';
import 'package:zxing2/qrcode.dart';

/// get [WhatsappClient] from `WhatsappBotFlutter.connect()`
/// please do not try to create on your own
class WhatsappClient {
  Page page;
  Browser browser;
  late WppEvents wppEvents;

  late Wpp wpp;
  late WppAuth wppAuth;

  WhatsappClient({required this.page, required this.browser}) {
    wpp = Wpp(page);
    wppAuth = WppAuth(page);
    wppEvents = WppEvents(page);
    wppEvents.init().then((value) {
      WhatsappLogger.log("WppEvents initialized");
    });
  }

  /// [isConnected] is to check if we are still connected to the WhatsappPage
  bool get isConnected => browser.isConnected && !page.isClosed;

  /// [connectionEventStream] will give update of Connection Events
  Stream<ConnectionEvent> get connectionEventStream =>
      wppEvents.connectionEventStreamController.stream;

  ///[messageEvents] will give update of all new messages
  Stream<Message> get messageEvents =>
      wppEvents.messageEventStreamController.stream;

  /// [disconnect] will close the browser instance and set values to null
  Future<void> disconnect({
    bool tryLogout = false,
  }) async {
    try {
      if (tryLogout) await logout();
      browser.close();
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }

  ///[logout] will try to logout only if We are connected and already logged in
  Future<void> logout() async {
    try {
      if (isConnected && await wppAuth.isAuthenticated()) {
        await wppAuth.logout();
      }
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }

  /// open Whatsapp and send message
  /// [sendMessage] may throw errors if contents not loaded on time
  /// or if this method completed without any issue , they probably message sent successfully
  /// `progress` callback will give update for the message sending progress
  Future<void> sendTextMessage({
    required String countryCode,
    required String phone,
    required String message,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    var sendResult = await page.evaluate(
      '''() => WPP.chat.sendTextMessage("$phoneNum", "$message");''',
    );
    WhatsappLogger.log("SendResult : $sendResult");
  }

  Future<void> sendFileMessage({
    required String countryCode,
    required String phone,
    required WhatsappFileType fileType,
    required List<int> fileBytes,
    String? caption,
    String? mimetype,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    String base64Image = base64Encode(fileBytes);
    String mimeType = mimetype ?? _getMimeType(fileType);
    String imgData = "data:$mimeType;base64,$base64Image";
    var sendResult = await page
        .evaluate('''(phone,imgData,caption) => WPP.chat.sendFileMessage(
        phone,imgData,
        {
          type: 'image',
          caption: caption
        });''', args: [phoneNum, imgData, caption]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  Future<void> sendLocationMessage({
    required String phone,
    required String countryCode,
    required String lat,
    required String long,
    String? name,
    String? address,
    String? url,
  }) async {
    Page page = await _validateMessage(countryCode, phone);
    countryCode = countryCode.replaceAll("+", "");
    String phoneNum = "$countryCode$phone@c.us";
    var sendResult = await page.evaluate(
        '''(phone,lat,long,address,name,url) => WPP.chat.sendLocationMessage(phone, {
              lat: lat,
              lng: long,
              name: name, 
              address: address,
              url: url 
            });
            ''',
        args: [phoneNum, lat, long, address, name, url]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  /// [validateMessage] will verify if data passed is correct or not
  Future<Page> _validateMessage(countryCode, String phone) async {
    if (!isConnected) {
      throw WhatsappException(
          message: "WhatsappClient no connected , please reconnect",
          exceptionType: WhatsappExceptionType.clientNotConnected);
    }

    countryCode = countryCode.replaceAll("+", "");

    bool isAuthenticated = await wppAuth.isAuthenticated();
    if (!isAuthenticated) {
      throw WhatsappException(
          message: "Please login first",
          exceptionType: WhatsappExceptionType.unAuthorized);
    }

    // String phoneNum = "$countryCode$phone@c.us";
    // bool isValid = await _wpp.isValidContact(page, phoneNum);
    // if (!isValid) {
    //   throw WhatsappException(
    //       message: "Invalid contact number",
    //       exceptionType: WhatsappExceptionType.inValidContact);
    // }
    return page;
  }

  /// [convertStringToQrCode] will convert a Text into a qrCode , which we can print in Terminal
  /// used in scanning code from terminal if we are using this in pure Dart project
  /// make sure to run dart project in terminal , not in DebugConsole for proper Qr representation
  String convertStringToQrCode(String text) {
    var qrcode = Encoder.encode(text, ErrorCorrectionLevel.l);
    var matrix = qrcode.matrix!;
    var stringBuffer = StringBuffer();
    for (var y = 0; y < matrix.height; y += 2) {
      for (var x = 0; x < matrix.width; x++) {
        final y1 = matrix.get(x, y) == 1;
        final y2 = (y + 1 < matrix.height) ? matrix.get(x, y + 1) == 1 : false;

        if (y1 && y2) {
          stringBuffer.write('█');
        } else if (y1) {
          stringBuffer.write('▀');
        } else if (y2) {
          stringBuffer.write('▄');
        } else {
          stringBuffer.write(' ');
        }
      }
      stringBuffer.writeln();
    }
    return stringBuffer.toString();
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
