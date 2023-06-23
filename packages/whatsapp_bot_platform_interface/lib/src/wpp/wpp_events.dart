import 'dart:async';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppEvents {
  WpClientInterface wpClient;
  WppEvents(this.wpClient);

  // To get update of all messages
  final StreamController<Message> messageEventStreamController =
      StreamController.broadcast();

  // To get update of all Calls
  final StreamController<CallEvent> callEventStreamController =
      StreamController.broadcast();

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
      case "messageEvent":
        _onNewMessage(eventData);
        break;
      case "connectionEvent":
        _onConnectionEvent(eventData);
        break;
      case "callEvent":
        _onCallEvent(eventData);
    }
  }

  void _onNewMessage(msg) {
    try {
      Message message = Message.fromJson(msg);
      messageEventStreamController.add(message);
    } catch (e) {
      WhatsappLogger.log("onMessageError : $e");
    }
  }

  void _onCallEvent(call) {
    try {
      CallEvent callEvent = CallEvent.fromJson(call);
      callEventStreamController.add(callEvent);
    } catch (e) {
      WhatsappLogger.log("onCallEvent : $e");
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
      default:
        WhatsappLogger.log("Unknown Event : $event");
    }
    if (connectionEvent == null) return;
    connectionEventStreamController.add(connectionEvent);
  }
}
