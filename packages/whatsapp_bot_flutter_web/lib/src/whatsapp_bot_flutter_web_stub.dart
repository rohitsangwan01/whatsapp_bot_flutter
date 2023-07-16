// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:typed_data';

import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

/// To make sure this plugin compiles on non web platforms
class WhatsappBotFlutterWeb {
  static Future<WhatsappClient?> connect({
    Function(ConnectionEvent)? onConnectionEvent,
    Function(String qrCodeUrl, Uint8List? qrCodeImage)? onQrCode,
    int qrCodeWaitDurationSeconds = 60,
  }) async {
    return null;
  }
}
