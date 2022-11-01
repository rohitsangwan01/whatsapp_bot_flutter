import 'dart:convert';

import 'package:puppeteer/puppeteer.dart';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';

import '../../whatsapp_bot_flutter.dart';

class WppChat {
  Page page;
  WppChat(this.page);

  /// [sendMessage] may throw errors if passed an invalid contact
  /// or if this method completed without any issue , then probably message sent successfully
  /// add `replyMessageId` to quote message
  Future sendTextMessage({
    required String phone,
    required String message,
    MessageId? replyMessageId,
  }) async {
    return await _executeMethod(
        '''(phone,message,replyId) => WPP.chat.sendTextMessage(phone, message, {
            quotedMsg: replyId
          });''',
        args: [parsePhone(phone), message, replyMessageId?.serialized],
        methodName: "sendTextMessage");
  }

  Future sendContactCard({
    required String phone,
    required String contactPhone,
    required String contactName,
  }) async {
    return await _executeMethod(
        '''(phone,contactPhone,contactName) => WPP.chat.sendVCardContactMessage(phone, {
            id: contactPhone,
            name: contactName
          });''',
        args: [parsePhone(phone), parsePhone(contactPhone), contactName],
        methodName: "sendContactCard");
  }

  ///send file messages using [sendFileMessage]
  /// make sure to send fileType , we can also pass optional mimeType
  /// `replyMessageId` will send a quote message to the given messageId
  /// add `caption` to attach a text with the file
  Future sendFileMessage({
    required String phone,
    required WhatsappFileType fileType,
    required List<int> fileBytes,
    String? caption,
    String? mimetype,
    MessageId? replyMessageId,
  }) async {
    await validateConnection(page);
    String phoneNum = parsePhone(phone);

    String base64Image = base64Encode(fileBytes);
    String mimeType = mimetype ?? getMimeType(fileType);
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
    return sendResult;
  }

  ///send a locationMessage using [sendLocationMessage]
  Future sendLocationMessage({
    required String phone,
    required String lat,
    required String long,
    String? name,
    String? address,
    String? url,
  }) async {
    return await _executeMethod(
        '''(phone,lat,long,address,name,url) => WPP.chat.sendLocationMessage(phone, {
              lat: lat,
              lng: long,
              name: name, 
              address: address,
              url: url 
            });
            ''',
        args: [parsePhone(phone), lat, long, address, name, url],
        methodName: "sendLocationMessage");
  }

  ///Pass phone with correct format in [archive] , and
  ///archive = true to archive , and false to unarchive
  Future<void> archive({required String phone, bool archive = true}) async {
    return await _executeMethod(
      '''(phone,archive) => WPP.chat.archive(phone, archive);''',
      args: [parsePhone(phone), archive],
      methodName: "Archive",
    );
  }

  /// check if the given Phone number is a valid phone number
  Future<bool> isValidContact(String phoneNumber) async {
    await validateConnection(page);
    try {
      await page.evaluate(
        '''(phone) => WPP.contact.queryExists(phone);''',
        args: [phoneNumber],
      );
      return true;
    } catch (e) {
      WhatsappLogger.log(e);
      return false;
    }
  }

  /// to check if we [canMute] phone number
  Future<bool> canMute(phone) async =>
      await _executeMethod('''(phone) =>WPP.chat.canMute(phone);''',
          args: [parsePhone(phone)], methodName: "CanMute");

  ///Mute a chat, you can use  expiration and use unix timestamp (seconds only)
  Future mute({
    required String phone,
    required int expirationUnixTimeStamp,
  }) async {
    if (!await canMute(phone)) throw "Cannot Mute $phone";
    return await _executeMethod(
        '''(phone,expirationTime) =>WPP.chat.mute(phone,{expiration: expirationTime});''',
        args: [parsePhone(phone), expirationUnixTimeStamp], methodName: "Mute");
  }

  /// Un mute chat
  Future unmute({required String phone}) async {
    return await _executeMethod('''(phone) =>WPP.chat.unmute(phone);''',
        args: [parsePhone(phone)], methodName: "unmute");
  }

  /// [clear] chat
  Future clear({
    required String phone,
    bool keepStarred = false,
  }) async =>
      await _executeMethod(
          '''(phone,keepStarred) =>WPP.chat.clear(phone,keepStarred);''',
          args: [parsePhone(phone), keepStarred], methodName: "ClearChat");

  /// [delete] chat
  Future delete({
    required String phone,
  }) async =>
      await _executeMethod('''(phone) =>WPP.chat.delete(phone);''',
          args: [parsePhone(phone)], methodName: "DeleteChat");

  ///Get timestamp of last seen using [getLastSeen]
  /// return either a timestamp or 0 if last seen off
  Future<int> getLastSeen({required String phone}) async {
    var lastSeen = await _executeMethod(
        '''(phone) =>WPP.chat.getLastSeen(phone);''',
        args: [parsePhone(phone)], methodName: "GetLastSeen");
    if (lastSeen.runtimeType == bool) return lastSeen ? 1 : 0;
    return lastSeen;
  }

  /// get all Chats using [getChats]
  Future getChats({bool? onlyUser, bool? onlyGroups}) async {
    if (onlyUser == true) {
      return await _executeMethod('''() => WPP.chat.list({onlyUsers: true});''',
          methodName: "GetChats");
    } else if (onlyGroups == true) {
      return await _executeMethod(
          '''() => WPP.chat.list({onlyGroups: true});''',
          methodName: "GetChats");
    } else {
      return await _executeMethod('''() =>  WPP.chat.list();''',
          methodName: "GetChats");
    }
  }

  ///Mark a chat as read and send SEEN event
  Future markAsSeen({required String phone}) async {
    return await _executeMethod('''(phone) =>WPP.chat.markIsRead(phone);''',
        args: [parsePhone(phone)], methodName: "MarkIsRead");
  }

  ///Mark a chat as unread
  Future markAsUnread({required String phone}) async {
    return await _executeMethod('''(phone) =>WPP.chat.markIsUnread(phone);''',
        args: [parsePhone(phone)], methodName: "MarkIsUnread");
  }

  ///pin/unpin to chat
  Future pin({required String phone, bool pin = true}) async {
    return await _executeMethod('''(phone,pin) =>WPP.chat.pin(phone,pin);''',
        args: [parsePhone(phone), pin], methodName: "pin");
  }

  /// Delete messages
  Future deleteMessages({
    required String phone,
    required List<String> messageIds,
  }) async {
    return await _executeMethod(
        '''(phone,messageIds) =>WPP.chat.deleteMessage(phone,messageIds);''',
        args: [parsePhone(phone), messageIds], methodName: "deleteMessages");
  }

  /// Download the blob of a media message
  Future downloadMedia({required String mediaMessageId}) async {
    return await _executeMethod(
        '''(mediaMessageId) =>WPP.chat.downloadMedia(mediaMessageId);''',
        args: [mediaMessageId], methodName: "downloadMedia");
  }

  /// Fetch messages from a chat
  Future getMessages({required String phone, int count = -1}) async {
    return await _executeMethod(
        '''(phone,cnt) =>WPP.chat.getMessages(phone,{count: cnt,});''',
        args: [parsePhone(phone), count], methodName: "getMessages");
  }

  /// Send a create poll message , Note: This only works for groups
  Future sendCreatePollMessage(
      {required String phone,
      required String pollName,
      required List<String> pollOptions}) async {
    return await _executeMethod(
        '''(phone,pollName,pollOptions) =>WPP.chat.sendCreatePollMessage(phone,pollName,pollOptions);''',
        args: [parsePhone(phone), pollName, pollOptions],
        methodName: "sendCreatePollMessage");
  }

// common method to execute a task
  Future _executeMethod(
    String method, {
    List<dynamic>? args,
    String methodName = "",
  }) async {
    await validateConnection(page);
    var result = await page.evaluate(method, args: args);
    WhatsappLogger.log("${methodName}Result : $result");
    return result;
  }
}
