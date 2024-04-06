import 'dart:convert';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppChat {
  WpClientInterface wpClient;
  WppChat(this.wpClient);

  /// [sendMessage] may throw errors if passed an invalid contact
  /// or if this method completed without any issue , then probably message sent successfully
  /// add `replyMessageId` to quote message
  Future sendTextMessage({
    required String phone,
    required String message,
    String? templateTitle,
    String? templateFooter,
    bool useTemplate = false,
    List<MessageButtons>? buttons,
    MessageId? replyMessageId,
  }) async {
    String? replyText = replyMessageId?.serialized;
    String? buttonsText = buttons?.map((e) => e.toJson()).toList().toString();
    return await wpClient.evaluateJs(
        '''WPP.chat.sendTextMessage(${phone.phoneParse}, ${message.jsParse}, {
            quotedMsg: ${replyText.jsParse},
            useTemplateButtons: ${useTemplate.jsParse},
            buttons:$buttonsText,
            title: ${templateTitle.jsParse},
            footer: ${templateFooter.jsParse}
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
  String? fileName,
  String? caption,
  String? mimetype,
  MessageId? replyMessageId,
  String? templateTitle,
  String? templateFooter,
  bool useTemplate = false,
  bool isViewOnce = false,
  bool audioAsPtt = false,
  List<MessageButtons>? buttons,
}) async {
  String base64Image = base64Encode(fileBytes);
  String mimeType = mimetype ?? getMimeType(fileType, fileName, fileBytes);
  String fileData = "data:$mimeType;base64,$base64Image";

  String fileTypeName = "image";
  if (mimeType.split("/").length > 1) {
    fileTypeName = mimeType.split("/").first;
  }

  // Check for video file type
  if (fileTypeName == "video") {
    fileTypeName = "video"; // Set the correct file type for videos
  }

  String? replyTextId = replyMessageId?.serialized;
  String? buttonsText = buttons?.map((e) => e.toJson()).toList().toString();

  String source = '''WPP.chat.sendFileMessage(${phone.phoneParse},${fileData.jsParse},{
    type: ${fileTypeName.jsParse},
    isPtt: ${audioAsPtt.jsParse},
    isViewOnce: ${isViewOnce.jsParse},
    filename: ${fileName.jsParse},
    caption: ${caption.jsParse},
    quotedMsg: ${replyTextId.jsParse},
    useTemplateButtons: ${useTemplate.jsParse},
    buttons:$buttonsText,
    title: ${templateTitle.jsParse},
    footer: ${templateFooter.jsParse}
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
        .evaluateJs('''WPP.chat.sendLocationMessage(${phone.phoneParse}, {
              lat: ${lat.jsParse},
              lng: ${long.jsParse},
              name: ${name.jsParse},
              address: ${address.jsParse},
              url: ${url.jsParse},
            });
            ''', methodName: "sendLocationMessage");
  }

  ///Pass phone with correct format in [archive] , and
  ///archive = true to archive , and false to unarchive
  Future<void> archive({required String phone, bool archive = true}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.archive(${phone.phoneParse}, $archive);''',
      methodName: "Archive",
    );
  }

  /// check if the given Phone number is a valid phone number
  Future<bool> isValidContact({required String phone}) async {
    await wpClient.evaluateJs(
      '''WPP.contact.queryExists(${phone.phoneParse});''',
      methodName: "isValidContact",
    );
    // return true by default , it will crash on any issue
    return true;
  }

  /// to check if we [canMute] phone number
  Future<bool> canMute({required String phone}) async =>
      await wpClient.evaluateJs('''WPP.chat.canMute(${phone.phoneParse});''',
          methodName: "CanMute");

  ///Mute a chat, you can use  expiration and use unix timestamp (seconds only)
  Future mute({
    required String phone,
    required int expirationUnixTimeStamp,
  }) async {
    if (!await canMute(phone: phone)) throw "Cannot Mute $phone";
    return await wpClient.evaluateJs(
        '''WPP.chat.mute(${phone.phoneParse},{expiration: $expirationUnixTimeStamp});''',
        methodName: "Mute");
  }

  /// Un mute chat
  Future unmute({required String phone}) async {
    return await wpClient.evaluateJs(
        '''WPP.chat.unmute(${phone.phoneParse});''',
        methodName: "unmute");
  }

  /// [clear] chat
  Future clear({
    required String phone,
    bool keepStarred = false,
  }) async =>
      await wpClient.evaluateJs(
          '''WPP.chat.clear(${phone.phoneParse},$keepStarred);''',
          methodName: "ClearChat");

  /// [delete] chat
  Future delete({
    required String phone,
  }) async =>
      await wpClient.evaluateJs('''WPP.chat.delete(${phone.phoneParse});''',
          methodName: "DeleteChat");

  ///Get timestamp of last seen using [getLastSeen]
  /// return either a timestamp or 0 if last seen off
  Future<int?> getLastSeen({required String phone}) async {
    var lastSeen = await wpClient.evaluateJs(
        '''WPP.chat.getLastSeen(${phone.phoneParse});''',
        methodName: "GetLastSeen");
    if (lastSeen.runtimeType == bool) return lastSeen ? 1 : 0;
    if (lastSeen.runtimeType == int) return lastSeen;
    return null;
  }

  /// get all Chats using [getChats]
  Future getChats({
    bool onlyUser = false,
    bool onlyGroups = false,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.list({
            onlyUsers: ${onlyUser.jsParse},
            onlyGroups: ${onlyGroups.jsParse}
         });''',
      methodName: "GetChats",
      forceJsonParseResult: true,
    );
  }

  ///Mark a chat as read and send SEEN event
  Future markAsSeen({required String phone}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.markIsRead(${phone.phoneParse});''',
      methodName: "MarkIsRead",
    );
  }

  Future markIsComposing({required String phone, int timeout = 5000}) async {
  await wpClient.evaluateJs(
    '''WPP.chat.markIsComposing(${phone.phoneParse});''',
    methodName: "markIsComposing",
  );

  // Wait for the timeout period.
  await Future.delayed(Duration(milliseconds: timeout));

  // Mark the chat as paused.
  await wpClient.evaluateJs(
    '''WPP.chat.markIsPaused(${phone.phoneParse});''',
    methodName: "markIsPaused",
  );
}

Future markIsRecording({required String phone, int timeout = 5000}) async {
  await wpClient.evaluateJs(
    '''WPP.chat.markIsRecording(${phone.phoneParse});''',
    methodName: "markIsRecording",
  );

  // Wait for the timeout period.
  await Future.delayed(Duration(milliseconds: timeout));

  // Mark the chat as paused.
  await wpClient.evaluateJs(
    '''WPP.chat.markIsPaused(${phone.phoneParse});''',
    methodName: "markIsPaused",
  );
}

  ///Mark a chat as unread
  Future markAsUnread({required String phone}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.markIsUnread(${phone.phoneParse});''',
      methodName: "MarkIsUnread",
    );
  }

  ///pin/unpin to chat
  Future pin({required String phone, bool pin = true}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.pin(${phone.phoneParse},$pin);''',
      methodName: "pin",
    );
  }

  /// Delete message
  /// Set revoke: true if you want to delete for everyone in group chat
  Future deleteMessage({
    required String phone,
    required String messageId,
    bool deleteMediaInDevice = false,
    bool revoke = false,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.deleteMessage(${phone.phoneParse},${messageId.jsParse}, $deleteMediaInDevice, $revoke);''',
      methodName: "deleteMessage",
    );
  }

  /// Download the base64 of a media message
  Future<Map<String, dynamic>?> downloadMedia({
    required MessageId messageId,
  }) async {
    String mediaSerialized = messageId.serialized;
    String? base64 = await wpClient.evaluateJs(
      '''WPP.chat.downloadMedia(${mediaSerialized.jsParse}).then(WPP.util.blobToBase64);''',
      methodName: "downloadMedia",
    );
    if (base64 == null) return null;
    return base64ToMap(base64);
  }

  /// Fetch messages from a chat
  Future getMessages({required String phone, int count = -1}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.getMessages(${phone.phoneParse},{count: $count,});''',
      methodName: "getMessages",
      forceJsonParseResult: true,
    );
  }

  /// Send a create poll message , Note: This only works for groups
  Future sendCreatePollMessage(
      {required String phone,
      required String pollName,
      required List<String> pollOptions}) async {
    return await wpClient.evaluateJs(
      '''WPP.chat.sendCreatePollMessage(${phone.phoneParse},${pollName.jsParse},${pollOptions.jsParse});''',
      methodName: "sendCreatePollMessage",
    );
  }

  /// [rejectCall] will reject incoming call
  Future rejectCall({String? callId}) async {
    return await wpClient.evaluateJs(
      '''WPP.call.rejectCall(${callId.jsParse});''',
      methodName: "RejectCallResult",
    );
  }

  /// Emoji list: https://unicode.org/emoji/charts/full-emoji-list.html
  /// To remove reaction, set [emoji] to null
  Future sendReactionToMessage({
    required MessageId messageId,
    String? emoji,
  }) async {
    String? serialized = messageId.serialized;
    return await wpClient.evaluateJs(
      '''WPP.chat.sendReactionToMessage(${serialized.jsParse}, ${emoji != null ? emoji.jsParse : false});''',
      methodName: "sendReactionToMessage",
    );
  }

  /// [forwardTextMessage] may throw errors if passed an invalid contact
  /// or if this method completed without any issue , then probably message sent successfully
  Future forwardTextMessage({
    required String phone,
    required MessageId messageId,
    bool displayCaptionText = false,
    bool multicast = false,
  }) async {
    String? serialized = messageId.serialized;
    return await wpClient.evaluateJs(
        '''WPP.chat.forwardMessage(${phone.phoneParse}, ${serialized.jsParse}, {
            displayCaptionText: $displayCaptionText,
            multicast: $multicast,
          });''',
        methodName: "forwardMessage");
  }




}
