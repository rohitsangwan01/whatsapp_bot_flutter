import 'dart:async';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppEvents {
  WpClientInterface wpClient;
  WppEvents(this.wpClient);

  // To get update of all Connections
  final StreamController<ConnectionEvent> connectionEventStreamController =
      StreamController.broadcast();

  /// call init() once on a page
  /// to add eventListeners
  Future<void> init() async {
    await wpClient.initializeEventListener(_onNewEvent);
  }

  void _onNewEvent(String eventName, dynamic eventData) {
    switch (eventName) {
      case "connectionEvent":
        _onConnectionEvent(eventData);
        break;
    }
  }

  void _onConnectionEvent(event) {
    ConnectionEvent? connectionEvent;
    switch (event) {
      case "authenticated":
        connectionEvent = ConnectionEvent.authenticated;
        break;
      case "logout":
        connectionEvent = ConnectionEvent.logout;
        break;
      case "auth_code_change":
        connectionEvent = ConnectionEvent.authCodeChange;
        break;
      case "main_loaded":
        connectionEvent = ConnectionEvent.connecting;
        break;
      case "main_ready":
        connectionEvent = ConnectionEvent.connected;
        break;
      case "require_auth":
        connectionEvent = ConnectionEvent.requireAuth;
        break;
      case "disconnected":
        connectionEvent = ConnectionEvent.disconnected;
        break;
      case "connected":
        connectionEvent = ConnectionEvent.connected;
        break;
      default:
        WhatsappLogger.log("Unknown Event : $event");
    }
    if (connectionEvent == null) return;
    connectionEventStreamController.add(connectionEvent);
  }
}
