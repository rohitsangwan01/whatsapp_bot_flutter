import 'package:whatsapp_bot_platform_interface/src/models/models.dart';
import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

class WppGroup {
  WpClientInterface wpClient;
  WppGroup(this.wpClient);

  Future openChatAt({
    required String groupId,
    required MessageId messageId,
  }) =>
      wpClient.evaluateJs('WPP.chat.openChatAt(${groupId.groupParse}, ${messageId.serialized.jsParse});');

  Future sendTextMessage({
    required String groupId,
    required String message,
    String? templateTitle,
    String? templateFooter,
    bool useTemplate = false,
    List<MessageButtons>? buttons,
    MessageId? replyMessageId,
  }) async {
    String? replyText = replyMessageId?.serialized;
    String? buttonsText = buttons?.map((e) => e.toJson()).toList().toString();
    return wpClient.evaluateJs('''WPP.chat.sendTextMessage(${groupId.groupParse}, ${message.jsParse}, {
            quotedMsg: ${replyText.jsParse},
            useTemplateButtons: ${useTemplate.jsParse},
            buttons:$buttonsText,
            title: ${templateTitle.jsParse},
            footer: ${templateFooter.jsParse}
          });''', methodName: "sendTextMessage");
  }

  /// To add participants to a group
  Future createGroup({required String groupName}) async {
    return await wpClient.evaluateJs('''
        WPP.group.create(${groupName.jsParse} , []);
      ''', methodName: "createGroup");
  }

  /// To get participants of a group
  Future getParticipants({required String groupId}) async {
    return await wpClient.evaluateJs(
      '''WPP.group.getParticipants(${groupId.groupParse});''',
      methodName: "getParticipants",
      forceJsonParseResult: true,
    );
  }

  /// To get all groups
  Future getAllGroups() async {
    return await wpClient.evaluateJs(
      '''WPP.group.getAllGroups();''',
      methodName: "getAllGroups",
      forceJsonParseResult: true,
    );
  }

  /// Set the group subject
  Future setSubject({
    required String groupId,
    required String subject,
  }) async {
    return wpClient.evaluateJs(
      '''WPP.group.setSubject(${groupId.groupParse}, ${subject.jsParse});''',
      methodName: 'setSubject',
    );
  }

  /// To add participants to a group
  Future addParticipants({
    required String groupId,
    required List<String> phoneNumbers,
  }) async {
    List<String> parseList = phoneNumbers.map((e) => e.phoneParse).toList();
    return await wpClient.evaluateJs(
      '''WPP.group.addParticipants(${groupId.groupParse},${parseList});''',
      methodName: "addParticipants",
    );
  }

  /// To reomve participants from a group
  Future removeParticipants({
    required String groupId,
    required List<String> phoneNumbers,
  }) async {
    List<String> parseList = phoneNumbers.map((e) => e.phoneParse).toList();
    return await wpClient.evaluateJs(
      '''WPP.group.removeParticipants(${groupId.groupParse}, ${parseList});''',
      methodName: "removeParticipants",
    );
  }
}
