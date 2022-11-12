import 'package:whatsapp_bot_flutter/src/model/qr_code_image.dart';

/// Interface for creating a Whatsapp Client

typedef OnNewEventFromListener = Function(String eventName, dynamic eventData);

abstract class WpClientInterface {
  Future injectJs(String content);

  Future<dynamic> evaluateJs(String source, {String? methodName});

  Future<void> dispose();

  bool isConnected();

  Future initializeEventListener(OnNewEventFromListener onNewEventFromListener);

  Future<QrCodeImage?> getQrCode();
}
