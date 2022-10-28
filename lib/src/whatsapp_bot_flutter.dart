import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/connection_event.dart';
import 'package:whatsapp_bot_flutter/src/model/message.dart';
import 'package:whatsapp_bot_flutter/src/model/whatsapp_file_type.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'puppeteer_service.dart';
import 'package:zxing2/qrcode.dart';

class WhatsappBotFlutter {
  static final _puppeteerService = PuppeteerService();

  /// [connect] will call onSuccess callback , or QrCode on getting QrCode to Scan
  static Future<void> connect({
    String? sessionDirectory,
    bool? headless,
    Function(String)? onQrCode,
    Function(String)? onError,
    Function()? onSuccess,
    Function(int)? progress,
    Duration? connectionTimeout,
  }) async {
    // dispose any pending tasks first
    disconnect();
    // Try to connect and login again
    await _puppeteerService.connectAndLogin(
      sessionDirectory: sessionDirectory,
      headless: headless,
      onError: onError,
      onQrCode: onQrCode,
      onSuccess: onSuccess,
      connectionTimeout: connectionTimeout,
      progress: progress,
    );
  }

  /// call [disconnect] to dispose browse and close all resources
  static disconnect() {
    _puppeteerService.dispose();
  }

  /// [sendMessage] to send messages to the given phone number
  /// listen for progress updates by `progress` callback
  static Future<void> sendTextMessage({
    required String phone,
    required String countryCode,
    required String message,
  }) async {
    await _puppeteerService.sendTextMessage(
      countryCode: countryCode,
      phone: phone,
      message: message,
    );
  }

  static Future<void> sendFileMessage({
    required String phone,
    required String countryCode,
    required List<int> fileBytes,
    required WhatsappFileType fileType,
    String? caption,
    String? mimetype,
  }) async {
    await _puppeteerService.sendFileMessage(
      countryCode: countryCode,
      phone: phone,
      caption: caption,
      fileBytes: fileBytes,
      fileType: fileType,
      mimetype: mimetype,
    );
  }

  static Future<void> sendLocationMessage({
    required String phone,
    required String countryCode,
    required String lat,
    required String long,
    String? name,
    String? address,
    String? url,
  }) async {
    await _puppeteerService.sendLocationMessage(
      countryCode: countryCode,
      phone: phone,
      lat: lat,
      long: long,
      address: address,
      name: name,
      url: url,
    );
  }

  /// [convertStringToQrCode] will convert a Text into a qrCode , which we can print in Terminal
  /// used in scanning code from terminal if we are using this in pure Dart project
  /// make sure to run dart project in terminal , not in DebugConsole for proper Qr representation
  static String convertStringToQrCode(String text) {
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

  /// To print logs from this library
  /// set `enableLogs(true)`
  /// by default its false
  static enableLogs(bool enable) {
    WhatsappLogger.enableLogger = enable;
  }

  /// [connectionEventStream] will give update of Connection Events
  static Stream<ConnectionEvent> connectionEventStream =
      WppEvents.connectionEventStreamController.stream;

  static Stream<Message> messageEvents =
      WppEvents.messageEventStreamController.stream;
}
