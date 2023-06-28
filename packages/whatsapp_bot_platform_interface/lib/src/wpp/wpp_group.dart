import 'package:whatsapp_bot_platform_interface/whatsapp_bot_platform_interface.dart';

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

  //TODO: fix this for desktop
  Future getAllGroups() async {
    return await wpClient.evaluateJs(
      '''WPP.group.getAllGroups();''',
      methodName: "getAllGroups",
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
