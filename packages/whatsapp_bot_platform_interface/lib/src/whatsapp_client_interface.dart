import 'package:whatsapp_bot_platform_interface/src/model/export_models.dart';

/// Interface for creating a Whatsapp Client

typedef OnNewEventFromListener = Function(String eventName, dynamic eventData);

abstract class WpClientInterface {
  Future injectJs(String content);

  Future<dynamic> evaluateJs(
    String source, {
    String? methodName,
    bool tryPromise,
  });

  Future<void> dispose();

  bool isConnected();

  Future initializeEventListener(OnNewEventFromListener onNewEventFromListener);

  Future<QrCodeImage?> getQrCode();

  Future<void> on(String event, Function(dynamic) callback);

  Future<void> off(String event);
}
