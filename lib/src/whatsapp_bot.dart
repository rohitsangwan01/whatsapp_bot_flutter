// ignore_for_file: avoid_print

import 'package:whatsapp_bot/src/helper/puppeteer_service.dart';

class WhatsappBot {
  static final _puppeteerService = PuppeteerService();

  /// `connect` will call onSuccess callback , or QrCode on getting QrCode to Scan
  static Future<void> connect({
    String? sessionDirectory,
    Function(String)? onQrCode,
    Function(String)? onError,
    Function()? onSuccess,
    Function(int)? progress,
    Duration? connectionTimeout,
  }) async {
    // dispose any pending tasks first
    dispose();
    // Try to connect and login again
    await _puppeteerService.connectAndLogin(
      sessionDirectory: sessionDirectory,
      onError: onError,
      onQrCode: onQrCode,
      onSuccess: onSuccess,
      connectionTimeout: connectionTimeout,
      progress: progress,
    );
  }

  // call dispose to close all resources
  static dispose() {
    _puppeteerService.dispose();
  }

  static void sendMessage({
    required String phone,
    required String countryCode,
    required String message,
  }) async {
    await _puppeteerService.sendMessage(
      countryCode: countryCode,
      phone: phone,
      message: message,
    );
  }
}
