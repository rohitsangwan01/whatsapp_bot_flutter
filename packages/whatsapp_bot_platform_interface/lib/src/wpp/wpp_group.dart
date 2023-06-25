import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

//TODO: fix all these methods on desktop/dart
class WppGroup {
  WpClientInterface wpClient;
  WppGroup(this.wpClient);

  /// To add participants to a group
  Future createGroup({required String groupName}) async {
    return await wpClient.evaluateJs('''
        WPP.group.create(${groupName.jsParse} , []);
      ''', methodName: "createGroup");
  }

  Future getParticipants({required String groupId}) async {
    return await wpClient.evaluateJs(
      '''WPP.group.getParticipants(${groupId.groupParse});''',
      methodName: "getParticipants",
    );
  }

  Future getAllGroups() async {
    return await wpClient.evaluateJs(
      '''WPP.group.getAllGroups();''',
      methodName: "getAllGroups",
    );
  }

  /// To add participants to a group
  Future addParticipants({
    required String groupId,
    required String phoneNumber,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.group.addParticipants(${groupId.groupParse}, ${phoneNumber.phoneParse});''',
      methodName: "addParticipants",
    );
  }

  /// To remove participants from a group
  Future removeParticipants({
    required String groupId,
    required String phoneNumber,
  }) async {
    return await wpClient.evaluateJs(
      '''WPP.group.removeParticipants(${groupId.groupParse}, ${phoneNumber.phoneParse});''',
      methodName: "removeParticipants",
    );
  }

  /// Change group subject
  Future setSubject({
    required String groupId,
    required String subject,
  }) async {
    return wpClient.evaluateJs(
      '''WPP.group.setSubject(${groupId.phoneParse}, ${subject.jsParse});''',
      methodName: 'setSubject',
    );
  }
}
