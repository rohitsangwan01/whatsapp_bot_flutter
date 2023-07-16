// ignore_for_file: avoid_print

import 'dart:async';

import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

/// To make sure this plugin compiles on non web platforms
class WhatsappBotFlutterWeb {
  static Future<WhatsappClient?> connect() async {
    return null;
  }
}
