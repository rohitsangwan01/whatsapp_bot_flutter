// ignore_for_file: avoid_print

import 'helper/puppeteer_service.dart';

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
    dispose();
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

  // call dispose to close all resources
  static dispose() {
    _puppeteerService.dispose();
  }

  /// [sendMessage] to send messages to the given phone number
  /// listen for progress updates by `progress` callback
  static Future<void> sendMessage({
    required String phone,
    required String countryCode,
    required String message,
    Function(int)? progress,
  }) async {
    await _puppeteerService.sendMessage(
      countryCode: countryCode,
      phone: phone,
      message: message,
      progress: progress,
    );
  }
}
