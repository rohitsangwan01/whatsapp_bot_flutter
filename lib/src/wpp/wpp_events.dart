import 'dart:async';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/model/connection_event.dart';
import 'package:whatsapp_bot_flutter/src/model/message.dart';

class WppEvents {
  // To get update of all messages
  static final StreamController<Message> messageEventStreamController =
      StreamController.broadcast();

  // To get update of all Connections
  static final StreamController<ConnectionEvent>
      connectionEventStreamController = StreamController.broadcast();

  static Future<void> addEventListeners(Page page) async {
    try {
      // Add Dart side method
      await _exposeListener(page);

      // Add all listeners
      await page.evaluate(
        '''()=>{
            WPP.on('chat.new_message', (msg) => {
              window.onCustomEvent("messageEvent",msg);
            });
            WPP.on('conn.authenticated', () => {
              window.onCustomEvent("connectionEvent","authenticated");
            });
             WPP.on('conn.logout', () => {
              window.onCustomEvent("connectionEvent","logout");
            });
            WPP.on('conn.auth_code_change', () => {
              window.onCustomEvent("connectionEvent","auth_code_change");
            });
            WPP.on('conn.main_loaded', () => {
              window.onCustomEvent("connectionEvent","main_loaded");
            });
            WPP.on('conn.main_ready', () => {
              window.onCustomEvent("connectionEvent","main_ready");
            });
             WPP.on('conn.qrcode_idle', () => {
              window.onCustomEvent("connectionEvent","qrcode_idle");
            });
            WPP.on('conn.require_auth', () => {
              window.onCustomEvent("connectionEvent","require_auth");
            });
        }''',
      );
    } catch (e) {
      // Ignore for now
    }
  }

  static void _onNewMessage(msg) {
    try {
      Message message = Message.fromJson(msg);
      messageEventStreamController.add(message);
    } catch (e) {
      WhatsappLogger.log("onMessageError : $e");
    }
  }

  static void _onConnectionEvent(event) {
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
        connectionEvent = ConnectionEvent.mainLoaded;
        break;
      case "main_ready":
        connectionEvent = ConnectionEvent.mainReady;
        break;
      case "qrcode_idle":
        connectionEvent = ConnectionEvent.qrcodeIdle;
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

  // make sure to call this method to expose this `onCustomEvent` function in JS
  static Future<void> _exposeListener(Page page) async {
    await page.exposeFunction("onCustomEvent", (type, data) {
      switch (type.toString()) {
        case "messageEvent":
          _onNewMessage(data);
          break;
        case "connectionEvent":
          _onConnectionEvent(data);
      }
    });
  }

  static Future<void> removeEventListeners(Page page) async {
    // TODO : remove all Event Listeners
  }
}
