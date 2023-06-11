import 'dart:async';

import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

/// get [WhatsappClient] from `WhatsappBotFlutter.connect()`
/// please do not try to create on your own
class WhatsappClient {
  WpClientInterface wpClient;

  // Wpp Classes
  late WppChat chat;
  late WppContact contact;
  late WppProfile profile;
  late WppEvents _wppEvents;
  late WppAuth _wppAuth;

  WhatsappClient({required this.wpClient}) {
    chat = WppChat(wpClient);
    contact = WppContact(wpClient);
    profile = WppProfile(wpClient);
    _wppAuth = WppAuth(wpClient);
    _wppEvents = WppEvents(wpClient);
    _wppEvents.init();
  }

  /// [isConnected] is to check if we are still connected to the WhatsappPage
  bool get isConnected => wpClient.isConnected();

  /// [isAuthenticated] is to check if we are loggedIn
  Future<bool> get isAuthenticated => _wppAuth.isAuthenticated();

  /// [isReadyToChat] is to check if whatsapp chat Page opened
  Future<bool> get isReadyToChat => _wppAuth.isMainReady();

  /// [connectionEventStream] will give update of Connection Events
  Stream<ConnectionEvent> get connectionEventStream =>
      _wppEvents.connectionEventStreamController.stream;

  ///[messageEvents] will give update of all new messages
  Stream<Message> get messageEvents =>
      _wppEvents.messageEventStreamController.stream;

  ///[callEvents] will give update of all calls
  Stream<CallEvent> get callEvents =>
      _wppEvents.callEventStreamController.stream;

  /// [disconnect] will close the browser instance and set values to null
  Future<void> disconnect({
    bool tryLogout = false,
  }) async {
    try {
      if (tryLogout) await logout();
      wpClient.dispose();
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }

  ///[logout] will try to logout only if We are connected and already logged in
  Future<void> logout() async {
    try {
      if (isConnected && await _wppAuth.isAuthenticated()) {
        await _wppAuth.logout();
      }
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }
}
