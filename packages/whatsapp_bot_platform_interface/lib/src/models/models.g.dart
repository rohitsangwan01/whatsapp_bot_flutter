// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      id: json['id'] as String,
      lastReceivedKey: json['lastReceivedKey'] == null
          ? null
          : LastReceivedKey.fromJson(
              json['lastReceivedKey'] as Map<String, dynamic>),
      t: (json['t'] as num?)?.toInt(),
      unreadCount: (json['unreadCount'] as num?)?.toInt(),
      unreadDividerOffset: (json['unreadDividerOffset'] as num?)?.toInt(),
      archive: json['archive'] as bool? ?? false,
      isLocked: json['isLocked'] as bool? ?? false,
      muteExpiration: (json['muteExpiration'] as num?)?.toInt(),
      isAutoMuted: json['isAutoMuted'] as bool? ?? false,
      notSpam: json['notSpam'] as bool? ?? false,
      pin: (json['pin'] as num?)?.toInt(),
      ephemeralDuration: (json['ephemeralDuration'] as num?)?.toInt(),
      ephemeralSettingTimestamp:
          (json['ephemeralSettingTimestamp'] as num?)?.toInt(),
      disappearingModeInitiator: json['disappearingModeInitiator'] as String?,
      disappearingModeTrigger: json['disappearingModeTrigger'] as String?,
      unreadMentionCount: (json['unreadMentionCount'] as num?)?.toInt(),
      hasUnreadMention: json['hasUnreadMention'] as bool? ?? false,
      archiveAtMentionViewedInDrawer:
          json['archiveAtMentionViewedInDrawer'] as bool? ?? false,
      hasChatBeenOpened: json['hasChatBeenOpened'] as bool? ?? false,
      tcToken: json['tcToken'] as Map<String, dynamic>?,
      tcTokenTimestamp: (json['tcTokenTimestamp'] as num?)?.toInt(),
      tcTokenSenderTimestamp: (json['tcTokenSenderTimestamp'] as num?)?.toInt(),
      endOfHistoryTransferType:
          (json['endOfHistoryTransferType'] as num?)?.toInt(),
      pendingInitialLoading: json['pendingInitialLoading'] as bool? ?? false,
      celebrationAnimationLastPlayed:
          (json['celebrationAnimationLastPlayed'] as num).toInt(),
      hasRequestedWelcomeMsg: json['hasRequestedWelcomeMsg'] as bool? ?? false,
      msgs: (json['msgs'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastReceivedKey': instance.lastReceivedKey,
      't': instance.t,
      'unreadCount': instance.unreadCount,
      'unreadDividerOffset': instance.unreadDividerOffset,
      'archive': instance.archive,
      'isLocked': instance.isLocked,
      'muteExpiration': instance.muteExpiration,
      'isAutoMuted': instance.isAutoMuted,
      'notSpam': instance.notSpam,
      'pin': instance.pin,
      'ephemeralDuration': instance.ephemeralDuration,
      'ephemeralSettingTimestamp': instance.ephemeralSettingTimestamp,
      'disappearingModeInitiator': instance.disappearingModeInitiator,
      'disappearingModeTrigger': instance.disappearingModeTrigger,
      'unreadMentionCount': instance.unreadMentionCount,
      'hasUnreadMention': instance.hasUnreadMention,
      'archiveAtMentionViewedInDrawer': instance.archiveAtMentionViewedInDrawer,
      'hasChatBeenOpened': instance.hasChatBeenOpened,
      'tcToken': instance.tcToken,
      'tcTokenTimestamp': instance.tcTokenTimestamp,
      'tcTokenSenderTimestamp': instance.tcTokenSenderTimestamp,
      'endOfHistoryTransferType': instance.endOfHistoryTransferType,
      'pendingInitialLoading': instance.pendingInitialLoading,
      'celebrationAnimationLastPlayed': instance.celebrationAnimationLastPlayed,
      'hasRequestedWelcomeMsg': instance.hasRequestedWelcomeMsg,
      'msgs': instance.msgs,
    };

_$LastReceivedKeyImpl _$$LastReceivedKeyImplFromJson(
        Map<String, dynamic> json) =>
    _$LastReceivedKeyImpl(
      fromMe: json['fromMe'] as bool? ?? false,
      remote: json['remote'] as String?,
      self: json['self'] as String?,
      serialized: json['_serialized'] as String?,
    );

Map<String, dynamic> _$$LastReceivedKeyImplToJson(
        _$LastReceivedKeyImpl instance) =>
    <String, dynamic>{
      'fromMe': instance.fromMe,
      'remote': instance.remote,
      'self': instance.self,
      '_serialized': instance.serialized,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] == null
          ? null
          : MessageId.fromJson(json['id'] as Map<String, dynamic>),
      body: json['body'] as String?,
      type: json['type'] as String?,
      t: (json['t'] as num?)?.toInt(),
      notifyName: json['notifyName'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      isNewMsg: json['isNewMsg'] as bool? ?? false,
      star: json['star'] as bool? ?? false,
      kicNotified: json['kicNotified'] as bool? ?? false,
      recvFresh: json['recvFresh'] as bool? ?? false,
      isFromTemplate: json['isFromTemplate'] as bool? ?? false,
      pollInvalidated: json['pollInvalidated'] as bool? ?? false,
      broadcast: json['broadcast'] as bool? ?? false,
      isForwarded: json['isForwarded'] as bool? ?? false,
      hasReaction: json['hasReaction'] as bool? ?? false,
      ephemeralOutOfSync: json['ephemeralOutOfSync'] as bool? ?? false,
      productHeaderImageRejected:
          json['productHeaderImageRejected'] as bool? ?? false,
      lastPlaybackProgress: (json['lastPlaybackProgress'] as num?)?.toInt(),
      isDynamicReplyButtonMsg:
          json['isDynamicReplyButtonMsg'] as bool? ?? false,
      isMdHistoryMsg: json['isMdHistoryMsg'] as bool? ?? false,
      stickerSentTs: (json['stickerSentTs'] as num?)?.toInt(),
      requiresDirectConnection:
          json['requiresDirectConnection'] as bool? ?? false,
      pttForwardedFeaturesEnabled:
          json['pttForwardedFeaturesEnabled'] as bool? ?? false,
      caption: json['caption'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'type': instance.type,
      't': instance.t,
      'notifyName': instance.notifyName,
      'from': instance.from,
      'to': instance.to,
      'isNewMsg': instance.isNewMsg,
      'star': instance.star,
      'kicNotified': instance.kicNotified,
      'recvFresh': instance.recvFresh,
      'isFromTemplate': instance.isFromTemplate,
      'pollInvalidated': instance.pollInvalidated,
      'broadcast': instance.broadcast,
      'isForwarded': instance.isForwarded,
      'hasReaction': instance.hasReaction,
      'ephemeralOutOfSync': instance.ephemeralOutOfSync,
      'productHeaderImageRejected': instance.productHeaderImageRejected,
      'lastPlaybackProgress': instance.lastPlaybackProgress,
      'isDynamicReplyButtonMsg': instance.isDynamicReplyButtonMsg,
      'isMdHistoryMsg': instance.isMdHistoryMsg,
      'stickerSentTs': instance.stickerSentTs,
      'requiresDirectConnection': instance.requiresDirectConnection,
      'pttForwardedFeaturesEnabled': instance.pttForwardedFeaturesEnabled,
      'caption': instance.caption,
    };

_$MessageIdImpl _$$MessageIdImplFromJson(Map<String, dynamic> json) =>
    _$MessageIdImpl(
      fromMe: json['fromMe'] as bool? ?? false,
      remote: json['remote'] as String?,
      id: json['id'] as String?,
      serialized: json['_serialized'] as String?,
    );

Map<String, dynamic> _$$MessageIdImplToJson(_$MessageIdImpl instance) =>
    <String, dynamic>{
      'fromMe': instance.fromMe,
      'remote': instance.remote,
      'id': instance.id,
      '_serialized': instance.serialized,
    };

_$CallEventImpl _$$CallEventImplFromJson(Map<String, dynamic> json) =>
    _$CallEventImpl(
      id: json['id'] as String?,
      isGroup: json['isGroup'] as bool? ?? false,
      isVideo: json['isVideo'] as bool? ?? false,
      offerTime: (json['offerTime'] as num?)?.toInt() ?? 0,
      sender: json['sender'] as String?,
      peerJid: json['peerJid'] as String?,
    );

Map<String, dynamic> _$$CallEventImplToJson(_$CallEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isGroup': instance.isGroup,
      'isVideo': instance.isVideo,
      'offerTime': instance.offerTime,
      'sender': instance.sender,
      'peerJid': instance.peerJid,
    };

_$QrCodeImageImpl _$$QrCodeImageImplFromJson(Map<String, dynamic> json) =>
    _$QrCodeImageImpl(
      urlCode: json['urlCode'] as String?,
      base64Image: json['base64Image'] as String?,
    );

Map<String, dynamic> _$$QrCodeImageImplToJson(_$QrCodeImageImpl instance) =>
    <String, dynamic>{
      'urlCode': instance.urlCode,
      'base64Image': instance.base64Image,
    };
