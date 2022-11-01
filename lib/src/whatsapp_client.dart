import 'dart:async';
import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_chat.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_contact.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_profile.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

/// get [WhatsappClient] from `WhatsappBotFlutter.connect()`
/// please do not try to create on your own
class WhatsappClient {
  Page page;
  Browser browser;
  late WppEvents _wppEvents;
  late WppAuth _wppAuth;

  // To access all chat features
  late WppChat chat;
  // To access all contact features
  late WppContact contact;
  // To access all profile features
  late WppProfile profile;

  WhatsappClient({required this.page, required this.browser}) {
    chat = WppChat(page);
    contact = WppContact(page);
    profile = WppProfile(page);
    _wppAuth = WppAuth(page);
    _wppEvents = WppEvents(page);
    _wppEvents.init().then((value) {
      WhatsappLogger.log("_wppEvents initialized");
    });
  }

  /// [isConnected] is to check if we are still connected to the WhatsappPage
  bool get isConnected => browser.isConnected && !page.isClosed;

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
      browser.close();
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

  /// [rejectCall] will reject incoming call
  Future<void> rejectCall({String? callId}) async {
    var result = await page.evaluate(
        '''(callId) => WPP.call.rejectCall(callId);;''',
        args: [callId]);
    WhatsappLogger.log("RejectCallResult : $result");
  }
}
