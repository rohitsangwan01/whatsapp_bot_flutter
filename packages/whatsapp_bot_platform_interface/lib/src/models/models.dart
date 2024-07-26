import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whatsapp_bot_platform_interface/src/helper/utils.dart';

part 'models.g.dart';
part 'models.freezed.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required final String id,
    required final LastReceivedKey? lastReceivedKey,
    required final int? t,
    required final int? unreadCount,
    required final int? unreadDividerOffset,
    @JsonKey(defaultValue: false) required final bool archive,
    @JsonKey(defaultValue: false) required final bool isLocked,
    required final int? muteExpiration,
    @JsonKey(defaultValue: false) required final bool isAutoMuted,
    @JsonKey(defaultValue: false) required final bool notSpam,
    required final int? pin,
    required final int? ephemeralDuration,
    required final int? ephemeralSettingTimestamp,
    required final String? disappearingModeInitiator,
    required final String? disappearingModeTrigger,
    required final int? unreadMentionCount,
    @JsonKey(defaultValue: false) required final bool hasUnreadMention,
    @JsonKey(defaultValue: false)
    required final bool archiveAtMentionViewedInDrawer,
    @JsonKey(defaultValue: false) required final bool hasChatBeenOpened,
    required final Map? tcToken,
    required final int? tcTokenTimestamp,
    required final int? tcTokenSenderTimestamp,
    required final int? endOfHistoryTransferType,
    @JsonKey(defaultValue: false) required final bool pendingInitialLoading,
    required final int celebrationAnimationLastPlayed,
    @JsonKey(defaultValue: false) required final bool hasRequestedWelcomeMsg,
    required final List<Message>? msgs,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

@freezed
class LastReceivedKey with _$LastReceivedKey {
  const factory LastReceivedKey({
    @JsonKey(defaultValue: false) required final bool fromMe,
    required final String? remote,
    required final String? self,
    @JsonKey(name: '_serialized') required final String? serialized,
  }) = _LastReceivedKey;

  factory LastReceivedKey.fromJson(Map<String, dynamic> json) =>
      _$LastReceivedKeyFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    required final MessageId? id,
    required final String? body,
    required final String? type,
    required final int? t,
    required final String? notifyName,
    required final String? from,
    required final String? to,
    @JsonKey(defaultValue: false) required final bool isNewMsg,
    @JsonKey(defaultValue: false) required final bool star,
    @JsonKey(defaultValue: false) required final bool kicNotified,
    @JsonKey(defaultValue: false) required final bool recvFresh,
    @JsonKey(defaultValue: false) required final bool isFromTemplate,
    @JsonKey(defaultValue: false) required final bool pollInvalidated,
    @JsonKey(defaultValue: false) required final bool broadcast,
    @JsonKey(defaultValue: false) required final bool isForwarded,
    @JsonKey(defaultValue: false) required final bool hasReaction,
    @JsonKey(defaultValue: false) required final bool ephemeralOutOfSync,
    @JsonKey(defaultValue: false)
    required final bool productHeaderImageRejected,
    required final int? lastPlaybackProgress,
    @JsonKey(defaultValue: false) required final bool isDynamicReplyButtonMsg,
    @JsonKey(defaultValue: false) required final bool isMdHistoryMsg,
    required final int? stickerSentTs,
    @JsonKey(defaultValue: false) required final bool requiresDirectConnection,
    @JsonKey(defaultValue: false)
    required final bool pttForwardedFeaturesEnabled,
    required final String? caption,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Because Mobile platforms returns data as list
  /// and desktop returns as map , so to unify the data
  static List<Message> parse(data) {
    if (data == null) return [];
    if (data is List) {
      return data.map((e) => Message.fromJson(e)).toList();
    } else if (data is Map<String, dynamic>) {
      return [Message.fromJson(data)];
    }
    return [];
  }
}

@freezed
class MessageId with _$MessageId {
  const factory MessageId({
    @JsonKey(defaultValue: false) required final bool fromMe,
    required final String? remote,
    required final String? id,
    @JsonKey(name: '_serialized') required final String? serialized,
  }) = _MessageId;

  factory MessageId.fromJson(Map<String, dynamic> json) =>
      _$MessageIdFromJson(json);
}

@freezed
class CallEvent with _$CallEvent {
  const factory CallEvent({
    required final String? id,
    @JsonKey(defaultValue: false) required final bool isGroup,
    @JsonKey(defaultValue: false) required final bool isVideo,
    @JsonKey(defaultValue: 0) required final int offerTime,
    required final String? sender,
    required final String? peerJid,
  }) = _CallEvent;

  factory CallEvent.fromJson(Map<String, dynamic> json) =>
      _$CallEventFromJson(json);

  static List<CallEvent> parse(data) {
    if (data == null) return [];
    if (data is List) {
      return data.map((e) => CallEvent.fromJson(e)).toList();
    } else if (data is Map<String, dynamic>) {
      return [CallEvent.fromJson(data)];
    }
    return [];
  }
}

class MessageButtons {
  String text;
  String buttonData;
  ButtonType buttonType;

  MessageButtons({
    required this.text,
    required this.buttonData,
    required this.buttonType,
  });

  Map<String, dynamic> toJson() {
    return {
      'text'.jsParse: text.jsParse,
      buttonType.name.jsParse: buttonData.jsParse,
    };
  }
}

@freezed
class QrCodeImage with _$QrCodeImage {
  const factory QrCodeImage({
    String? urlCode,
    String? base64Image,
  }) = _QrCodeImage;

  factory QrCodeImage.fromJson(Map<String, dynamic> json) =>
      _$QrCodeImageFromJson(json);
}

/// Whatsapp Events, https://wppconnect.io/wa-js/modules/ev.html
/// Add more events if needed from the above link
///
/// use WhatsappClient.on(eventName,(data){}) to listen to events and client.off(eventName) to stop listening
///
///
enum WhatsappEvent {
  // BlocklistEventTypes
  blocklistSync('blocklist.sync'),

  // CallEventTypes
  callIncomingCall('call.incoming_call'),

  // ChatEventTypes
  chatActiveChat('chat.active_chat'),
  chatLiveLocationEnd('chat.live_location_end'),
  chatLiveLocationStart('chat.live_location_start'),
  chatLiveLocationUpdate('chat.live_location_update'),
  chatMsgAckChange('chat.msg_ack_change'),
  chatMsgRevoke('chat.msg_revoke'),
  chatNewMessage('chat.new_message'),
  chatNewReaction('chat.new_reaction'),
  chatPollResponse('chat.poll_response'),
  chatPresenceChange('chat.presence_change'),
  chatUpdateLabel('chat.update_label'),

  // ConfigEventTypes
  configUpdate('config.update'),

  // ConnEventTypes
  connAuthCodeChange('conn.auth_code_change'),
  connAuthenticated('conn.authenticated'),
  connLogout('conn.logout'),
  connMainInit('conn.main_init'),
  connMainLoaded('conn.main_loaded'),
  connMainReady('conn.main_ready'),
  connNeedsUpdate('conn.needs_update'),
  connOnline('conn.online'),
  connQrCodeIdle('conn.qrcode_idle'),
  connRequireAuth('conn.require_auth'),

  // GroupEventTypes
  groupParticipantChanged('group.participant_changed'),

  // StatusEventTypes
  statusSync('status.sync'),

  // WebpackEvents
  webpackInjected('webpack.injected'),
  webpackReady('webpack.ready');

  const WhatsappEvent(this.value);
  final String value;

  static WhatsappEvent? parse(String value) {
    try {
      return WhatsappEvent.values.firstWhere((e) => e.value == value);
    } catch (_) {
      return null;
    }
  }
}

class WhatsappException implements Exception {
  late String message;
  late WhatsappExceptionType exceptionType;
  String? details;
  WhatsappException({
    this.message = "Something went wrong",
    this.exceptionType = WhatsappExceptionType.unknown,
    this.details,
  });

  @override
  String toString() {
    return "[ WhatsappException  type : $exceptionType , message : $message ]";
  }
}

enum ButtonType {
  id,
  url,
  phoneNumber,
}

enum ConnectionEvent {
  initializing,
  downloadingChrome,
  connectingChrome,
  waitingForLogin,
  waitingForQrScan,
  waitingForPhoneLink,
  connectingWhatsapp,
  authenticated,
  logout,
  authCodeChange,
  connecting,
  connected,
  disconnected,
  requireAuth,
}

enum WhatsappExceptionType {
  failedToConnect,
  unknown,
  connectionFailed,
  unAuthorized,
  inValidContact,
  clientNotConnected,
  clientErrorException,
}

enum WhatsappFileType {
  document,
  image,
  audio,
  pdf,
  unknown,
  video,
}
