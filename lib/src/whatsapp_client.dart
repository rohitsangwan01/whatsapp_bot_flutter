import 'dart:async';
import 'dart:convert';

import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_events.dart';
import 'package:whatsapp_bot_flutter/src/model/whatsapp_exception.dart';
import 'package:whatsapp_bot_flutter/src/wpp/wpp_auth.dart';
import 'package:whatsapp_bot_flutter/whatsapp_bot_flutter.dart';

/// get [WhatsappClient] from `WhatsappBotFlutter.connect()`
/// please do not try to create on your own
class WhatsappClient {
  Page page;
  Browser browser;
  late WppEvents wppEvents;
  late Wpp wpp;
  late WppAuth wppAuth;

  WhatsappClient({required this.page, required this.browser}) {
    wpp = Wpp(page);
    wppAuth = WppAuth(page);
    wppEvents = WppEvents(page);
    wppEvents.init().then((value) {
      WhatsappLogger.log("WppEvents initialized");
    });
  }

  /// [isConnected] is to check if we are still connected to the WhatsappPage
  bool get isConnected => browser.isConnected && !page.isClosed;

  /// [isAuthenticated] is to check if we are loggedIn
  Future<bool> get isAuthenticated => wppAuth.isAuthenticated();

  /// [isReadyToChat] is to check if whatsapp chat Page opened
  Future<bool> get isReadyToChat => wppAuth.isMainReady();

  /// [connectionEventStream] will give update of Connection Events
  Stream<ConnectionEvent> get connectionEventStream =>
      wppEvents.connectionEventStreamController.stream;

  ///[messageEvents] will give update of all new messages
  Stream<Message> get messageEvents =>
      wppEvents.messageEventStreamController.stream;

  ///[callEvents] will give update of all calls
  Stream<CallEvent> get callEvents =>
      wppEvents.callEventStreamController.stream;

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
      if (isConnected && await wppAuth.isAuthenticated()) {
        await wppAuth.logout();
      }
    } catch (e) {
      WhatsappLogger.log(e);
    }
  }

  /// [sendMessage] may throw errors if passed an invalid contact
  /// or if this method completed without any issue , then probably message sent successfully
  /// add `replyMessageId` to quote message
  Future<void> sendTextMessage({
    required String phone,
    required String message,
    MessageId? replyMessageId,
  }) async {
    await _validateConnection();
    String phoneNum = _parsePhone(phone);

    var sendResult = await page.evaluate(
        '''(phone,message,replyId) => WPP.chat.sendTextMessage(phone, message, {
            quotedMsg: replyId
          });''',
        args: [phoneNum, message, replyMessageId?.serialized]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  ///send file messages using [sendFileMessage]
  /// make sure to send fileType , we can also pass optional mimeType
  /// `replyMessageId` will send a quote message to the given messageId
  /// add `caption` to attach a text with the file
  Future<void> sendFileMessage({
    required String phone,
    required WhatsappFileType fileType,
    required List<int> fileBytes,
    String? caption,
    String? mimetype,
    MessageId? replyMessageId,
  }) async {
    await _validateConnection();
    String phoneNum = _parsePhone(phone);

    String base64Image = base64Encode(fileBytes);
    String mimeType = mimetype ?? _getMimeType(fileType);
    String fileData = "data:$mimeType;base64,$base64Image";
    String fileTypeName = "image";
    if (mimeType.split("/").length > 1) {
      fileTypeName = mimeType.split("/").first;
    }

    var sendResult = await page.evaluate(
        '''(phone,fileData,caption,fileType,replyId) => WPP.chat.sendFileMessage(
            phone,fileData,{
              type: fileType,
              caption: caption,
              quotedMsg: replyId
            });''',
        args: [phoneNum, fileData, caption, fileTypeName, replyMessageId?.serialized]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  ///send a locationMessage using [sendLocationMessage]
  Future<void> sendLocationMessage({
    required String phone,
    required String lat,
    required String long,
    String? name,
    String? address,
    String? url,
  }) async {
    await _validateConnection();
    String phoneNum = _parsePhone(phone);

    var sendResult = await page.evaluate(
        '''(phone,lat,long,address,name,url) => WPP.chat.sendLocationMessage(phone, {
              lat: lat,
              lng: long,
              name: name, 
              address: address,
              url: url 
            });
            ''',
        args: [phoneNum, lat, long, address, name, url]);
    WhatsappLogger.log("SendResult : $sendResult");
  }

  /// [rejectCall] will reject incoming call
  Future<void> rejectCall({String? callId}) async {
    var result = await page.evaluate(
        '''(callId) => WPP.call.rejectCall(callId);;''',
        args: [callId]);
    WhatsappLogger.log("RejectCallResult : $result");
  }

  /// [validateMessage] will verify if data passed is correct or not
  Future _validateConnection() async {
    if (!isConnected) {
      throw WhatsappException(
          message: "WhatsappClient no connected , please reconnect",
          exceptionType: WhatsappExceptionType.clientNotConnected);
    }

    bool isAuthenticated = await wppAuth.isAuthenticated();
    if (!isAuthenticated) {
      throw WhatsappException(
          message: "Please login first",
          exceptionType: WhatsappExceptionType.unAuthorized);
    }
  }

  /// [_parsePhone] will try to convert phone number in required format
  String _parsePhone(String phone) {
    String suffix = "@c.us";
    String phoneNum = phone.replaceAll("+", "");
    if (!phone.contains(suffix)) {
      phoneNum = "$phoneNum$suffix";
    }
    return phoneNum;
  }

  /// [_getMimeType] returns default mimeType
  String _getMimeType(WhatsappFileType fileType) {
    switch (fileType) {
      case WhatsappFileType.document:
        return "application/msword";
      case WhatsappFileType.image:
        return "image/jpeg";
      case WhatsappFileType.audio:
        return "audio/mp3";
      // case WhatsappFileType.video:
      //   return "video/mp4";
    }
  }
}
