import 'dart:developer' as developer;

import 'package:whatsapp_bot_flutter/src/model/whatsapp_exception.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';

import '../../whatsapp_bot_flutter.dart';

class WhatsappLogger {
  static bool enableLogger = false;

  static void log(log) {
    if (!enableLogger) return;
    developer.log(log.toString(), name: 'WhatsappBotFlutter');
  }
}

class WhatsAppMetadata {
  static String whatsAppURL = "https://web.whatsapp.com/";
  // "web.whatsapp.com/🌎/en/";
  static String whatsAppURLForceDesktop = "web.whatsapp.com//";
  static String userAgent =
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.39 Safari/537.36';
}

// /// [validateMessage] will verify if data passed is correct or not
Future validateConnection(WpClientInterface wpClient) async {
  if (!wpClient.isConnected()) {
    throw WhatsappException(
        message: "WhatsappClient no connected , please reconnect",
        exceptionType: WhatsappExceptionType.clientNotConnected);
  }

  bool isAuthenticated = await WppAuth(wpClient).isAuthenticated();
  if (!isAuthenticated) {
    throw WhatsappException(
        message: "Please login first",
        exceptionType: WhatsappExceptionType.unAuthorized);
  }
}

/// Use [JsParse] extension on data we pass in Javascript string
extension JsParser on dynamic {
  dynamic get jsParse {
    if (this == null) {
      return null;
    } else if (runtimeType == String) {
      return '''"${this.replaceAll("\n", "\\n").replaceAll("\"", "\\\"")}"''';
    } else {
      // return same for now
      return this;
    }
  }

  String get phoneParse {
    // ignore: unnecessary_string_interpolations
    return parsePhone(this).jsParse;
  }
}

/// [_parsePhone] will try to convert phone number in required format
String parsePhone(String phone) {
  String chatSuffix = "@c.us";
  //String groupSuffix = "@g.us";
  String phoneNum = phone.replaceAll("+", "");
  if (!phone.contains(".us")) {
    phoneNum = "$phoneNum$chatSuffix";
  }
  return phoneNum;
}

/// [getMimeType] returns default mimeType
String getMimeType(WhatsappFileType fileType) {
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
