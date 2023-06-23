import 'dart:developer' as developer;

import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';
import 'package:zxing2/qrcode.dart';

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

class WhatsappBotUtils {
  /// [convertStringToQrCode] will convert a Text into a qrCode , which we can print in Terminal
  /// used in scanning code from terminal if we are using this in pure Dart project
  static String convertStringToQrCode(String text) {
    var qrCode = Encoder.encode(text, ErrorCorrectionLevel.l);
    var matrix = qrCode.matrix!;
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

  /// To print logs from this library set `enableLogs(true)`, by default its false
  static enableLogs(bool enable) {
    WhatsappLogger.enableLogger = enable;
  }
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
    } else if (runtimeType == List<String>) {
      return '''[${this.map((String e) => e.jsParse).join(",")}]''';
    } else {
      // return same for now
      return this;
    }
  }

  String get phoneParse => parsePhone(this).jsParse;

  String get groupParse => parseGroup(this).jsParse;
}

/// [parsePhone] will try to convert phone number in required format
String parsePhone(String phone) {
  String chatSuffix = "@c.us";
  //String groupSuffix = "@g.us";
  String phoneNum = phone.replaceAll("+", "");
  if (!phone.contains(".us")) {
    phoneNum = "$phoneNum$chatSuffix";
  }
  return phoneNum;
}

/// [parseGroup] will try to convert group number in required format
String parseGroup(String phone) {
  String groupSuffix = "@g.us";
  String phoneNum = phone.replaceAll("+", "");
  if (!phone.contains(".us")) {
    phoneNum = "$phoneNum$groupSuffix";
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
