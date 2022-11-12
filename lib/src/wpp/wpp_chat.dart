import 'dart:convert';
import 'package:whatsapp_bot_flutter/src/helper/utils.dart';
import 'package:whatsapp_bot_flutter/src/helper/whatsapp_client_interface.dart';
import '../../whatsapp_bot_flutter.dart';

class WppChat {
  WpClientInterface wpClient;
  WppChat(this.wpClient);

  /// [sendMessage] may throw errors if passed an invalid contact
  /// or if this method completed without any issue , then probably message sent successfully
  /// add `replyMessageId` to quote message
  Future sendTextMessage({
    required String phone,
    required String message,
    MessageId? replyMessageId,
  }) async {
    String? replyText = replyMessageId?.serialized;
    return await wpClient.evaluateJs(
        '''WPP.chat.sendTextMessage(${phone.phoneParse}, ${message.jsParse}, {
            quotedMsg: ${replyText.jsParse}
          });''',
        methodName: "sendTextMessage");
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
    String base64Image = base64Encode(fileBytes);
    String mimeType = mimetype ?? getMimeType(fileType);
    String fileData = "data:$mimeType;base64,$base64Image";
    String fileTypeName = "image";
    if (mimeType.split("/").length > 1) {
      fileTypeName = mimeType.split("/").first;
    }
    String? replyTextId = replyMessageId?.serialized;
    String source =
        '''WPP.chat.sendFileMessage(${phone.phoneParse},${fileData.jsParse},{
                    type: ${fileTypeName.jsParse},
                    caption: ${caption.jsParse},
                    quotedMsg: ${replyTextId.jsParse}
                  });''';
    var sendResult = await wpClient.evaluateJs(source);
    WhatsappLogger.log("SendResult : $sendResult");
    return sendResult;
  }

  Future sendContactCard({
    required String phone,
    required String contactPhone,
    required String contactName,
  }) async {
    return await wpClient
        .evaluateJs('''WPP.chat.sendVCardContactMessage(${phone.phoneParse}, {
            id: ${contactPhone.phoneParse},
            name: ${contactName.jsParse}
          });''', methodName: "sendContactCard");
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
    return await wpClient
        .evaluateJs('''WPP.chat.sendLocationMessage("${parsePhone(phone)}", {
              lat: "$lat",
              lng: "$long",
              name: "$name", 
              address: "$address",
              url: "$url" 
            });
            ''', methodName: "sendLocationMessage");
  }

  ///Pass phone with correct format in [archive] , and
  ///archive = true to archive , and false to unarchive
  Future<void> archive({required String phone, bool archive = true}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.archive("${parsePhone(phone)}", $archive);''',
      methodName: "Archive",
    );
  }

  /// check if the given Phone number is a valid phone number
  Future<bool> isValidContact(String phone) async {
    return await wpClient.evaluateJs(
      '''WPP.contact.queryExists("${parsePhone(phone)}");''',
      methodName: "isValidContact",
    );
  }

  /// to check if we [canMute] phone number
  Future<bool> canMute(phone) async =>
      await wpClient.evaluateJs('''WPP.chat.canMute("${parsePhone(phone)}");''',
          methodName: "CanMute");

  ///Mute a chat, you can use  expiration and use unix timestamp (seconds only)
  Future mute({
    required String phone,
    required int expirationUnixTimeStamp,
  }) async {
    if (!await canMute(phone)) throw "Cannot Mute $phone";
    return await wpClient.evaluateJs(
        '''WPP.chat.mute("${parsePhone(phone)}",{expiration: $expirationUnixTimeStamp});''',
        methodName: "Mute");
  }

  /// Un mute chat
  Future unmute({required String phone}) async {
    return await wpClient.evaluateJs(
        '''=>WPP.chat.unmute("${parsePhone(phone)}");''',
        methodName: "unmute");
  }

  /// [clear] chat
  Future clear({
    required String phone,
    bool keepStarred = false,
  }) async =>
      await wpClient.evaluateJs(
          '''WPP.chat.clear("${parsePhone(phone)}",$keepStarred);''',
          methodName: "ClearChat");

  /// [delete] chat
  Future delete({
    required String phone,
  }) async =>
      await wpClient.evaluateJs('''WPP.chat.delete("${parsePhone(phone)}");''',
          methodName: "DeleteChat");

  ///Get timestamp of last seen using [getLastSeen]
  /// return either a timestamp or 0 if last seen off
  Future<int> getLastSeen({required String phone}) async {
    var lastSeen = await wpClient.evaluateJs(
        '''WPP.chat.getLastSeen("${parsePhone(phone)}");''',
        methodName: "GetLastSeen");
    if (lastSeen.runtimeType == bool) return lastSeen ? 1 : 0;
    return lastSeen;
  }

  /// get all Chats using [getChats]
  Future getChats({bool? onlyUser, bool? onlyGroups}) async {
    if (onlyUser == true) {
      return await wpClient.evaluateJs('''WPP.chat.list({onlyUsers: true});''',
          methodName: "GetChats");
    } else if (onlyGroups == true) {
      return await wpClient.evaluateJs('''WPP.chat.list({onlyGroups: true});''',
          methodName: "GetChats");
    } else {
      return await wpClient
          .evaluateJs('''WPP.chat.list();''', methodName: "GetChats");
    }
  }

  ///Mark a chat as read and send SEEN event
  Future markAsSeen({required String phone}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.markIsRead("${parsePhone(phone)}");''',
        methodName: "MarkIsRead");
  }

  ///Mark a chat as unread
  Future markAsUnread({required String phone}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.markIsUnread("${parsePhone(phone)}");''',
        methodName: "MarkIsUnread");
  }

  ///pin/unpin to chat
  Future pin({required String phone, bool pin = true}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.pin("${parsePhone(phone)}",$pin);''',
        methodName: "pin");
  }

  /// Delete messages
  Future deleteMessages({
    required String phone,
    required List<String> messageIds,
  }) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.deleteMessage("${parsePhone(phone)}",$messageIds);''',
        methodName: "deleteMessages");
  }

  /// Download the blob of a media message
  Future downloadMedia({required String mediaMessageId}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.downloadMedia("$mediaMessageId");''',
        methodName: "downloadMedia");
  }

  /// Fetch messages from a chat
  Future getMessages({required String phone, int count = -1}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.getMessages("${parsePhone(phone)}",{count: $count,});''',
        methodName: "getMessages");
  }

  /// Send a create poll message , Note: This only works for groups
  Future sendCreatePollMessage(
      {required String phone,
      required String pollName,
      required List<String> pollOptions}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.sendCreatePollMessage("${parsePhone(phone)}","$pollName",$pollOptions);''',
        methodName: "sendCreatePollMessage");
  }

  /// [rejectCall] will reject incoming call
  Future rejectCall({String? callId}) async {
    return await wpClient.evaluateJs(
      '''WPP.call.rejectCall(${callId.jsParse});''',
      methodName: "RejectCallResult",
    );
  }
}
