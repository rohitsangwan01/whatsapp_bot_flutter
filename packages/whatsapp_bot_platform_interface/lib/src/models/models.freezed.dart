// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
mixin _$Chat {
  String get id => throw _privateConstructorUsedError;
  LastReceivedKey get lastReceivedKey => throw _privateConstructorUsedError;
  int get t => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  int get unreadDividerOffset => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get archive => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isLocked => throw _privateConstructorUsedError;
  int get muteExpiration => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isAutoMuted => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get notSpam => throw _privateConstructorUsedError;
  int get pin => throw _privateConstructorUsedError;
  int get ephemeralDuration => throw _privateConstructorUsedError;
  int get ephemeralSettingTimestamp => throw _privateConstructorUsedError;
  String get disappearingModeInitiator => throw _privateConstructorUsedError;
  String get disappearingModeTrigger => throw _privateConstructorUsedError;
  int get unreadMentionCount => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get hasUnreadMention => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get archiveAtMentionViewedInDrawer => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get hasChatBeenOpened => throw _privateConstructorUsedError;
  Map<dynamic, dynamic> get tcToken => throw _privateConstructorUsedError;
  int get tcTokenTimestamp => throw _privateConstructorUsedError;
  int get tcTokenSenderTimestamp => throw _privateConstructorUsedError;
  int get endOfHistoryTransferType => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get pendingInitialLoading => throw _privateConstructorUsedError;
  int get celebrationAnimationLastPlayed => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get hasRequestedWelcomeMsg => throw _privateConstructorUsedError;
  List<Message> get msgs => throw _privateConstructorUsedError;

  /// Serializes this Chat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Chat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res, Chat>;
  @useResult
  $Res call(
      {String id,
      LastReceivedKey lastReceivedKey,
      int t,
      int unreadCount,
      int unreadDividerOffset,
      @JsonKey(defaultValue: false) bool archive,
      @JsonKey(defaultValue: false) bool isLocked,
      int muteExpiration,
      @JsonKey(defaultValue: false) bool isAutoMuted,
      @JsonKey(defaultValue: false) bool notSpam,
      int pin,
      int ephemeralDuration,
      int ephemeralSettingTimestamp,
      String disappearingModeInitiator,
      String disappearingModeTrigger,
      int unreadMentionCount,
      @JsonKey(defaultValue: false) bool hasUnreadMention,
      @JsonKey(defaultValue: false) bool archiveAtMentionViewedInDrawer,
      @JsonKey(defaultValue: false) bool hasChatBeenOpened,
      Map<dynamic, dynamic> tcToken,
      int tcTokenTimestamp,
      int tcTokenSenderTimestamp,
      int endOfHistoryTransferType,
      @JsonKey(defaultValue: false) bool pendingInitialLoading,
      int celebrationAnimationLastPlayed,
      @JsonKey(defaultValue: false) bool hasRequestedWelcomeMsg,
      List<Message> msgs});

  $LastReceivedKeyCopyWith<$Res> get lastReceivedKey;
}

/// @nodoc
class _$ChatCopyWithImpl<$Res, $Val extends Chat>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Chat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastReceivedKey = null,
    Object? t = null,
    Object? unreadCount = null,
    Object? unreadDividerOffset = null,
    Object? archive = null,
    Object? isLocked = null,
    Object? muteExpiration = null,
    Object? isAutoMuted = null,
    Object? notSpam = null,
    Object? pin = null,
    Object? ephemeralDuration = null,
    Object? ephemeralSettingTimestamp = null,
    Object? disappearingModeInitiator = null,
    Object? disappearingModeTrigger = null,
    Object? unreadMentionCount = null,
    Object? hasUnreadMention = null,
    Object? archiveAtMentionViewedInDrawer = null,
    Object? hasChatBeenOpened = null,
    Object? tcToken = null,
    Object? tcTokenTimestamp = null,
    Object? tcTokenSenderTimestamp = null,
    Object? endOfHistoryTransferType = null,
    Object? pendingInitialLoading = null,
    Object? celebrationAnimationLastPlayed = null,
    Object? hasRequestedWelcomeMsg = null,
    Object? msgs = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastReceivedKey: null == lastReceivedKey
          ? _value.lastReceivedKey
          : lastReceivedKey // ignore: cast_nullable_to_non_nullable
              as LastReceivedKey,
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as int,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadDividerOffset: null == unreadDividerOffset
          ? _value.unreadDividerOffset
          : unreadDividerOffset // ignore: cast_nullable_to_non_nullable
              as int,
      archive: null == archive
          ? _value.archive
          : archive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      muteExpiration: null == muteExpiration
          ? _value.muteExpiration
          : muteExpiration // ignore: cast_nullable_to_non_nullable
              as int,
      isAutoMuted: null == isAutoMuted
          ? _value.isAutoMuted
          : isAutoMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      notSpam: null == notSpam
          ? _value.notSpam
          : notSpam // ignore: cast_nullable_to_non_nullable
              as bool,
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as int,
      ephemeralDuration: null == ephemeralDuration
          ? _value.ephemeralDuration
          : ephemeralDuration // ignore: cast_nullable_to_non_nullable
              as int,
      ephemeralSettingTimestamp: null == ephemeralSettingTimestamp
          ? _value.ephemeralSettingTimestamp
          : ephemeralSettingTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      disappearingModeInitiator: null == disappearingModeInitiator
          ? _value.disappearingModeInitiator
          : disappearingModeInitiator // ignore: cast_nullable_to_non_nullable
              as String,
      disappearingModeTrigger: null == disappearingModeTrigger
          ? _value.disappearingModeTrigger
          : disappearingModeTrigger // ignore: cast_nullable_to_non_nullable
              as String,
      unreadMentionCount: null == unreadMentionCount
          ? _value.unreadMentionCount
          : unreadMentionCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasUnreadMention: null == hasUnreadMention
          ? _value.hasUnreadMention
          : hasUnreadMention // ignore: cast_nullable_to_non_nullable
              as bool,
      archiveAtMentionViewedInDrawer: null == archiveAtMentionViewedInDrawer
          ? _value.archiveAtMentionViewedInDrawer
          : archiveAtMentionViewedInDrawer // ignore: cast_nullable_to_non_nullable
              as bool,
      hasChatBeenOpened: null == hasChatBeenOpened
          ? _value.hasChatBeenOpened
          : hasChatBeenOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      tcToken: null == tcToken
          ? _value.tcToken
          : tcToken // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      tcTokenTimestamp: null == tcTokenTimestamp
          ? _value.tcTokenTimestamp
          : tcTokenTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      tcTokenSenderTimestamp: null == tcTokenSenderTimestamp
          ? _value.tcTokenSenderTimestamp
          : tcTokenSenderTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      endOfHistoryTransferType: null == endOfHistoryTransferType
          ? _value.endOfHistoryTransferType
          : endOfHistoryTransferType // ignore: cast_nullable_to_non_nullable
              as int,
      pendingInitialLoading: null == pendingInitialLoading
          ? _value.pendingInitialLoading
          : pendingInitialLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      celebrationAnimationLastPlayed: null == celebrationAnimationLastPlayed
          ? _value.celebrationAnimationLastPlayed
          : celebrationAnimationLastPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      hasRequestedWelcomeMsg: null == hasRequestedWelcomeMsg
          ? _value.hasRequestedWelcomeMsg
          : hasRequestedWelcomeMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      msgs: null == msgs
          ? _value.msgs
          : msgs // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ) as $Val);
  }

  /// Create a copy of Chat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastReceivedKeyCopyWith<$Res> get lastReceivedKey {
    return $LastReceivedKeyCopyWith<$Res>(_value.lastReceivedKey, (value) {
      return _then(_value.copyWith(lastReceivedKey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatImplCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$ChatImplCopyWith(
          _$ChatImpl value, $Res Function(_$ChatImpl) then) =
      __$$ChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      LastReceivedKey lastReceivedKey,
      int t,
      int unreadCount,
      int unreadDividerOffset,
      @JsonKey(defaultValue: false) bool archive,
      @JsonKey(defaultValue: false) bool isLocked,
      int muteExpiration,
      @JsonKey(defaultValue: false) bool isAutoMuted,
      @JsonKey(defaultValue: false) bool notSpam,
      int pin,
      int ephemeralDuration,
      int ephemeralSettingTimestamp,
      String disappearingModeInitiator,
      String disappearingModeTrigger,
      int unreadMentionCount,
      @JsonKey(defaultValue: false) bool hasUnreadMention,
      @JsonKey(defaultValue: false) bool archiveAtMentionViewedInDrawer,
      @JsonKey(defaultValue: false) bool hasChatBeenOpened,
      Map<dynamic, dynamic> tcToken,
      int tcTokenTimestamp,
      int tcTokenSenderTimestamp,
      int endOfHistoryTransferType,
      @JsonKey(defaultValue: false) bool pendingInitialLoading,
      int celebrationAnimationLastPlayed,
      @JsonKey(defaultValue: false) bool hasRequestedWelcomeMsg,
      List<Message> msgs});

  @override
  $LastReceivedKeyCopyWith<$Res> get lastReceivedKey;
}

/// @nodoc
class __$$ChatImplCopyWithImpl<$Res>
    extends _$ChatCopyWithImpl<$Res, _$ChatImpl>
    implements _$$ChatImplCopyWith<$Res> {
  __$$ChatImplCopyWithImpl(_$ChatImpl _value, $Res Function(_$ChatImpl) _then)
      : super(_value, _then);

  /// Create a copy of Chat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastReceivedKey = null,
    Object? t = null,
    Object? unreadCount = null,
    Object? unreadDividerOffset = null,
    Object? archive = null,
    Object? isLocked = null,
    Object? muteExpiration = null,
    Object? isAutoMuted = null,
    Object? notSpam = null,
    Object? pin = null,
    Object? ephemeralDuration = null,
    Object? ephemeralSettingTimestamp = null,
    Object? disappearingModeInitiator = null,
    Object? disappearingModeTrigger = null,
    Object? unreadMentionCount = null,
    Object? hasUnreadMention = null,
    Object? archiveAtMentionViewedInDrawer = null,
    Object? hasChatBeenOpened = null,
    Object? tcToken = null,
    Object? tcTokenTimestamp = null,
    Object? tcTokenSenderTimestamp = null,
    Object? endOfHistoryTransferType = null,
    Object? pendingInitialLoading = null,
    Object? celebrationAnimationLastPlayed = null,
    Object? hasRequestedWelcomeMsg = null,
    Object? msgs = null,
  }) {
    return _then(_$ChatImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastReceivedKey: null == lastReceivedKey
          ? _value.lastReceivedKey
          : lastReceivedKey // ignore: cast_nullable_to_non_nullable
              as LastReceivedKey,
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as int,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadDividerOffset: null == unreadDividerOffset
          ? _value.unreadDividerOffset
          : unreadDividerOffset // ignore: cast_nullable_to_non_nullable
              as int,
      archive: null == archive
          ? _value.archive
          : archive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocked: null == isLocked
          ? _value.isLocked
          : isLocked // ignore: cast_nullable_to_non_nullable
              as bool,
      muteExpiration: null == muteExpiration
          ? _value.muteExpiration
          : muteExpiration // ignore: cast_nullable_to_non_nullable
              as int,
      isAutoMuted: null == isAutoMuted
          ? _value.isAutoMuted
          : isAutoMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      notSpam: null == notSpam
          ? _value.notSpam
          : notSpam // ignore: cast_nullable_to_non_nullable
              as bool,
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as int,
      ephemeralDuration: null == ephemeralDuration
          ? _value.ephemeralDuration
          : ephemeralDuration // ignore: cast_nullable_to_non_nullable
              as int,
      ephemeralSettingTimestamp: null == ephemeralSettingTimestamp
          ? _value.ephemeralSettingTimestamp
          : ephemeralSettingTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      disappearingModeInitiator: null == disappearingModeInitiator
          ? _value.disappearingModeInitiator
          : disappearingModeInitiator // ignore: cast_nullable_to_non_nullable
              as String,
      disappearingModeTrigger: null == disappearingModeTrigger
          ? _value.disappearingModeTrigger
          : disappearingModeTrigger // ignore: cast_nullable_to_non_nullable
              as String,
      unreadMentionCount: null == unreadMentionCount
          ? _value.unreadMentionCount
          : unreadMentionCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasUnreadMention: null == hasUnreadMention
          ? _value.hasUnreadMention
          : hasUnreadMention // ignore: cast_nullable_to_non_nullable
              as bool,
      archiveAtMentionViewedInDrawer: null == archiveAtMentionViewedInDrawer
          ? _value.archiveAtMentionViewedInDrawer
          : archiveAtMentionViewedInDrawer // ignore: cast_nullable_to_non_nullable
              as bool,
      hasChatBeenOpened: null == hasChatBeenOpened
          ? _value.hasChatBeenOpened
          : hasChatBeenOpened // ignore: cast_nullable_to_non_nullable
              as bool,
      tcToken: null == tcToken
          ? _value._tcToken
          : tcToken // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
      tcTokenTimestamp: null == tcTokenTimestamp
          ? _value.tcTokenTimestamp
          : tcTokenTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      tcTokenSenderTimestamp: null == tcTokenSenderTimestamp
          ? _value.tcTokenSenderTimestamp
          : tcTokenSenderTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      endOfHistoryTransferType: null == endOfHistoryTransferType
          ? _value.endOfHistoryTransferType
          : endOfHistoryTransferType // ignore: cast_nullable_to_non_nullable
              as int,
      pendingInitialLoading: null == pendingInitialLoading
          ? _value.pendingInitialLoading
          : pendingInitialLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      celebrationAnimationLastPlayed: null == celebrationAnimationLastPlayed
          ? _value.celebrationAnimationLastPlayed
          : celebrationAnimationLastPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      hasRequestedWelcomeMsg: null == hasRequestedWelcomeMsg
          ? _value.hasRequestedWelcomeMsg
          : hasRequestedWelcomeMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      msgs: null == msgs
          ? _value._msgs
          : msgs // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatImpl implements _Chat {
  const _$ChatImpl(
      {required this.id,
      required this.lastReceivedKey,
      required this.t,
      required this.unreadCount,
      required this.unreadDividerOffset,
      @JsonKey(defaultValue: false) required this.archive,
      @JsonKey(defaultValue: false) required this.isLocked,
      required this.muteExpiration,
      @JsonKey(defaultValue: false) required this.isAutoMuted,
      @JsonKey(defaultValue: false) required this.notSpam,
      required this.pin,
      required this.ephemeralDuration,
      required this.ephemeralSettingTimestamp,
      required this.disappearingModeInitiator,
      required this.disappearingModeTrigger,
      required this.unreadMentionCount,
      @JsonKey(defaultValue: false) required this.hasUnreadMention,
      @JsonKey(defaultValue: false)
      required this.archiveAtMentionViewedInDrawer,
      @JsonKey(defaultValue: false) required this.hasChatBeenOpened,
      required final Map<dynamic, dynamic> tcToken,
      required this.tcTokenTimestamp,
      required this.tcTokenSenderTimestamp,
      required this.endOfHistoryTransferType,
      @JsonKey(defaultValue: false) required this.pendingInitialLoading,
      required this.celebrationAnimationLastPlayed,
      @JsonKey(defaultValue: false) required this.hasRequestedWelcomeMsg,
      required final List<Message> msgs})
      : _tcToken = tcToken,
        _msgs = msgs;

  factory _$ChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatImplFromJson(json);

  @override
  final String id;
  @override
  final LastReceivedKey lastReceivedKey;
  @override
  final int t;
  @override
  final int unreadCount;
  @override
  final int unreadDividerOffset;
  @override
  @JsonKey(defaultValue: false)
  final bool archive;
  @override
  @JsonKey(defaultValue: false)
  final bool isLocked;
  @override
  final int muteExpiration;
  @override
  @JsonKey(defaultValue: false)
  final bool isAutoMuted;
  @override
  @JsonKey(defaultValue: false)
  final bool notSpam;
  @override
  final int pin;
  @override
  final int ephemeralDuration;
  @override
  final int ephemeralSettingTimestamp;
  @override
  final String disappearingModeInitiator;
  @override
  final String disappearingModeTrigger;
  @override
  final int unreadMentionCount;
  @override
  @JsonKey(defaultValue: false)
  final bool hasUnreadMention;
  @override
  @JsonKey(defaultValue: false)
  final bool archiveAtMentionViewedInDrawer;
  @override
  @JsonKey(defaultValue: false)
  final bool hasChatBeenOpened;
  final Map<dynamic, dynamic> _tcToken;
  @override
  Map<dynamic, dynamic> get tcToken {
    if (_tcToken is EqualUnmodifiableMapView) return _tcToken;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tcToken);
  }

  @override
  final int tcTokenTimestamp;
  @override
  final int tcTokenSenderTimestamp;
  @override
  final int endOfHistoryTransferType;
  @override
  @JsonKey(defaultValue: false)
  final bool pendingInitialLoading;
  @override
  final int celebrationAnimationLastPlayed;
  @override
  @JsonKey(defaultValue: false)
  final bool hasRequestedWelcomeMsg;
  final List<Message> _msgs;
  @override
  List<Message> get msgs {
    if (_msgs is EqualUnmodifiableListView) return _msgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_msgs);
  }

  @override
  String toString() {
    return 'Chat(id: $id, lastReceivedKey: $lastReceivedKey, t: $t, unreadCount: $unreadCount, unreadDividerOffset: $unreadDividerOffset, archive: $archive, isLocked: $isLocked, muteExpiration: $muteExpiration, isAutoMuted: $isAutoMuted, notSpam: $notSpam, pin: $pin, ephemeralDuration: $ephemeralDuration, ephemeralSettingTimestamp: $ephemeralSettingTimestamp, disappearingModeInitiator: $disappearingModeInitiator, disappearingModeTrigger: $disappearingModeTrigger, unreadMentionCount: $unreadMentionCount, hasUnreadMention: $hasUnreadMention, archiveAtMentionViewedInDrawer: $archiveAtMentionViewedInDrawer, hasChatBeenOpened: $hasChatBeenOpened, tcToken: $tcToken, tcTokenTimestamp: $tcTokenTimestamp, tcTokenSenderTimestamp: $tcTokenSenderTimestamp, endOfHistoryTransferType: $endOfHistoryTransferType, pendingInitialLoading: $pendingInitialLoading, celebrationAnimationLastPlayed: $celebrationAnimationLastPlayed, hasRequestedWelcomeMsg: $hasRequestedWelcomeMsg, msgs: $msgs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastReceivedKey, lastReceivedKey) ||
                other.lastReceivedKey == lastReceivedKey) &&
            (identical(other.t, t) || other.t == t) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.unreadDividerOffset, unreadDividerOffset) ||
                other.unreadDividerOffset == unreadDividerOffset) &&
            (identical(other.archive, archive) || other.archive == archive) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.muteExpiration, muteExpiration) ||
                other.muteExpiration == muteExpiration) &&
            (identical(other.isAutoMuted, isAutoMuted) ||
                other.isAutoMuted == isAutoMuted) &&
            (identical(other.notSpam, notSpam) || other.notSpam == notSpam) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.ephemeralDuration, ephemeralDuration) ||
                other.ephemeralDuration == ephemeralDuration) &&
            (identical(other.ephemeralSettingTimestamp, ephemeralSettingTimestamp) ||
                other.ephemeralSettingTimestamp == ephemeralSettingTimestamp) &&
            (identical(other.disappearingModeInitiator, disappearingModeInitiator) ||
                other.disappearingModeInitiator == disappearingModeInitiator) &&
            (identical(other.disappearingModeTrigger, disappearingModeTrigger) ||
                other.disappearingModeTrigger == disappearingModeTrigger) &&
            (identical(other.unreadMentionCount, unreadMentionCount) ||
                other.unreadMentionCount == unreadMentionCount) &&
            (identical(other.hasUnreadMention, hasUnreadMention) ||
                other.hasUnreadMention == hasUnreadMention) &&
            (identical(other.archiveAtMentionViewedInDrawer, archiveAtMentionViewedInDrawer) ||
                other.archiveAtMentionViewedInDrawer ==
                    archiveAtMentionViewedInDrawer) &&
            (identical(other.hasChatBeenOpened, hasChatBeenOpened) ||
                other.hasChatBeenOpened == hasChatBeenOpened) &&
            const DeepCollectionEquality().equals(other._tcToken, _tcToken) &&
            (identical(other.tcTokenTimestamp, tcTokenTimestamp) ||
                other.tcTokenTimestamp == tcTokenTimestamp) &&
            (identical(other.tcTokenSenderTimestamp, tcTokenSenderTimestamp) ||
                other.tcTokenSenderTimestamp == tcTokenSenderTimestamp) &&
            (identical(
                    other.endOfHistoryTransferType, endOfHistoryTransferType) ||
                other.endOfHistoryTransferType == endOfHistoryTransferType) &&
            (identical(other.pendingInitialLoading, pendingInitialLoading) ||
                other.pendingInitialLoading == pendingInitialLoading) &&
            (identical(other.celebrationAnimationLastPlayed,
                    celebrationAnimationLastPlayed) ||
                other.celebrationAnimationLastPlayed ==
                    celebrationAnimationLastPlayed) &&
            (identical(other.hasRequestedWelcomeMsg, hasRequestedWelcomeMsg) ||
                other.hasRequestedWelcomeMsg == hasRequestedWelcomeMsg) &&
            const DeepCollectionEquality().equals(other._msgs, _msgs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        lastReceivedKey,
        t,
        unreadCount,
        unreadDividerOffset,
        archive,
        isLocked,
        muteExpiration,
        isAutoMuted,
        notSpam,
        pin,
        ephemeralDuration,
        ephemeralSettingTimestamp,
        disappearingModeInitiator,
        disappearingModeTrigger,
        unreadMentionCount,
        hasUnreadMention,
        archiveAtMentionViewedInDrawer,
        hasChatBeenOpened,
        const DeepCollectionEquality().hash(_tcToken),
        tcTokenTimestamp,
        tcTokenSenderTimestamp,
        endOfHistoryTransferType,
        pendingInitialLoading,
        celebrationAnimationLastPlayed,
        hasRequestedWelcomeMsg,
        const DeepCollectionEquality().hash(_msgs)
      ]);

  /// Create a copy of Chat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      __$$ChatImplCopyWithImpl<_$ChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatImplToJson(
      this,
    );
  }
}

abstract class _Chat implements Chat {
  const factory _Chat(
      {required final String id,
      required final LastReceivedKey lastReceivedKey,
      required final int t,
      required final int unreadCount,
      required final int unreadDividerOffset,
      @JsonKey(defaultValue: false) required final bool archive,
      @JsonKey(defaultValue: false) required final bool isLocked,
      required final int muteExpiration,
      @JsonKey(defaultValue: false) required final bool isAutoMuted,
      @JsonKey(defaultValue: false) required final bool notSpam,
      required final int pin,
      required final int ephemeralDuration,
      required final int ephemeralSettingTimestamp,
      required final String disappearingModeInitiator,
      required final String disappearingModeTrigger,
      required final int unreadMentionCount,
      @JsonKey(defaultValue: false) required final bool hasUnreadMention,
      @JsonKey(defaultValue: false)
      required final bool archiveAtMentionViewedInDrawer,
      @JsonKey(defaultValue: false) required final bool hasChatBeenOpened,
      required final Map<dynamic, dynamic> tcToken,
      required final int tcTokenTimestamp,
      required final int tcTokenSenderTimestamp,
      required final int endOfHistoryTransferType,
      @JsonKey(defaultValue: false) required final bool pendingInitialLoading,
      required final int celebrationAnimationLastPlayed,
      @JsonKey(defaultValue: false) required final bool hasRequestedWelcomeMsg,
      required final List<Message> msgs}) = _$ChatImpl;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$ChatImpl.fromJson;

  @override
  String get id;
  @override
  LastReceivedKey get lastReceivedKey;
  @override
  int get t;
  @override
  int get unreadCount;
  @override
  int get unreadDividerOffset;
  @override
  @JsonKey(defaultValue: false)
  bool get archive;
  @override
  @JsonKey(defaultValue: false)
  bool get isLocked;
  @override
  int get muteExpiration;
  @override
  @JsonKey(defaultValue: false)
  bool get isAutoMuted;
  @override
  @JsonKey(defaultValue: false)
  bool get notSpam;
  @override
  int get pin;
  @override
  int get ephemeralDuration;
  @override
  int get ephemeralSettingTimestamp;
  @override
  String get disappearingModeInitiator;
  @override
  String get disappearingModeTrigger;
  @override
  int get unreadMentionCount;
  @override
  @JsonKey(defaultValue: false)
  bool get hasUnreadMention;
  @override
  @JsonKey(defaultValue: false)
  bool get archiveAtMentionViewedInDrawer;
  @override
  @JsonKey(defaultValue: false)
  bool get hasChatBeenOpened;
  @override
  Map<dynamic, dynamic> get tcToken;
  @override
  int get tcTokenTimestamp;
  @override
  int get tcTokenSenderTimestamp;
  @override
  int get endOfHistoryTransferType;
  @override
  @JsonKey(defaultValue: false)
  bool get pendingInitialLoading;
  @override
  int get celebrationAnimationLastPlayed;
  @override
  @JsonKey(defaultValue: false)
  bool get hasRequestedWelcomeMsg;
  @override
  List<Message> get msgs;

  /// Create a copy of Chat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastReceivedKey _$LastReceivedKeyFromJson(Map<String, dynamic> json) {
  return _LastReceivedKey.fromJson(json);
}

/// @nodoc
mixin _$LastReceivedKey {
  @JsonKey(defaultValue: false)
  bool get fromMe => throw _privateConstructorUsedError;
  String get remote => throw _privateConstructorUsedError;
  String get self => throw _privateConstructorUsedError;
  @JsonKey(name: '_serialized')
  String get serialized => throw _privateConstructorUsedError;

  /// Serializes this LastReceivedKey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastReceivedKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastReceivedKeyCopyWith<LastReceivedKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastReceivedKeyCopyWith<$Res> {
  factory $LastReceivedKeyCopyWith(
          LastReceivedKey value, $Res Function(LastReceivedKey) then) =
      _$LastReceivedKeyCopyWithImpl<$Res, LastReceivedKey>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: false) bool fromMe,
      String remote,
      String self,
      @JsonKey(name: '_serialized') String serialized});
}

/// @nodoc
class _$LastReceivedKeyCopyWithImpl<$Res, $Val extends LastReceivedKey>
    implements $LastReceivedKeyCopyWith<$Res> {
  _$LastReceivedKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastReceivedKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromMe = null,
    Object? remote = null,
    Object? self = null,
    Object? serialized = null,
  }) {
    return _then(_value.copyWith(
      fromMe: null == fromMe
          ? _value.fromMe
          : fromMe // ignore: cast_nullable_to_non_nullable
              as bool,
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      self: null == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String,
      serialized: null == serialized
          ? _value.serialized
          : serialized // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastReceivedKeyImplCopyWith<$Res>
    implements $LastReceivedKeyCopyWith<$Res> {
  factory _$$LastReceivedKeyImplCopyWith(_$LastReceivedKeyImpl value,
          $Res Function(_$LastReceivedKeyImpl) then) =
      __$$LastReceivedKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: false) bool fromMe,
      String remote,
      String self,
      @JsonKey(name: '_serialized') String serialized});
}

/// @nodoc
class __$$LastReceivedKeyImplCopyWithImpl<$Res>
    extends _$LastReceivedKeyCopyWithImpl<$Res, _$LastReceivedKeyImpl>
    implements _$$LastReceivedKeyImplCopyWith<$Res> {
  __$$LastReceivedKeyImplCopyWithImpl(
      _$LastReceivedKeyImpl _value, $Res Function(_$LastReceivedKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastReceivedKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromMe = null,
    Object? remote = null,
    Object? self = null,
    Object? serialized = null,
  }) {
    return _then(_$LastReceivedKeyImpl(
      fromMe: null == fromMe
          ? _value.fromMe
          : fromMe // ignore: cast_nullable_to_non_nullable
              as bool,
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      self: null == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String,
      serialized: null == serialized
          ? _value.serialized
          : serialized // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastReceivedKeyImpl implements _LastReceivedKey {
  const _$LastReceivedKeyImpl(
      {@JsonKey(defaultValue: false) required this.fromMe,
      required this.remote,
      required this.self,
      @JsonKey(name: '_serialized') required this.serialized});

  factory _$LastReceivedKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastReceivedKeyImplFromJson(json);

  @override
  @JsonKey(defaultValue: false)
  final bool fromMe;
  @override
  final String remote;
  @override
  final String self;
  @override
  @JsonKey(name: '_serialized')
  final String serialized;

  @override
  String toString() {
    return 'LastReceivedKey(fromMe: $fromMe, remote: $remote, self: $self, serialized: $serialized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastReceivedKeyImpl &&
            (identical(other.fromMe, fromMe) || other.fromMe == fromMe) &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.self, self) || other.self == self) &&
            (identical(other.serialized, serialized) ||
                other.serialized == serialized));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fromMe, remote, self, serialized);

  /// Create a copy of LastReceivedKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastReceivedKeyImplCopyWith<_$LastReceivedKeyImpl> get copyWith =>
      __$$LastReceivedKeyImplCopyWithImpl<_$LastReceivedKeyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastReceivedKeyImplToJson(
      this,
    );
  }
}

abstract class _LastReceivedKey implements LastReceivedKey {
  const factory _LastReceivedKey(
          {@JsonKey(defaultValue: false) required final bool fromMe,
          required final String remote,
          required final String self,
          @JsonKey(name: '_serialized') required final String serialized}) =
      _$LastReceivedKeyImpl;

  factory _LastReceivedKey.fromJson(Map<String, dynamic> json) =
      _$LastReceivedKeyImpl.fromJson;

  @override
  @JsonKey(defaultValue: false)
  bool get fromMe;
  @override
  String get remote;
  @override
  String get self;
  @override
  @JsonKey(name: '_serialized')
  String get serialized;

  /// Create a copy of LastReceivedKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastReceivedKeyImplCopyWith<_$LastReceivedKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  MessageId? get id => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get t => throw _privateConstructorUsedError;
  String get notifyName => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isNewMsg => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get star => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get kicNotified => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get recvFresh => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isFromTemplate => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get pollInvalidated => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get broadcast => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isForwarded => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get hasReaction => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get ephemeralOutOfSync => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get productHeaderImageRejected => throw _privateConstructorUsedError;
  int get lastPlaybackProgress => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isDynamicReplyButtonMsg => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isMdHistoryMsg => throw _privateConstructorUsedError;
  int get stickerSentTs => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get requiresDirectConnection => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get pttForwardedFeaturesEnabled => throw _privateConstructorUsedError;
  String get caption => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {MessageId? id,
      String body,
      String type,
      int t,
      String notifyName,
      String from,
      String to,
      @JsonKey(defaultValue: false) bool isNewMsg,
      @JsonKey(defaultValue: false) bool star,
      @JsonKey(defaultValue: false) bool kicNotified,
      @JsonKey(defaultValue: false) bool recvFresh,
      @JsonKey(defaultValue: false) bool isFromTemplate,
      @JsonKey(defaultValue: false) bool pollInvalidated,
      @JsonKey(defaultValue: false) bool broadcast,
      @JsonKey(defaultValue: false) bool isForwarded,
      @JsonKey(defaultValue: false) bool hasReaction,
      @JsonKey(defaultValue: false) bool ephemeralOutOfSync,
      @JsonKey(defaultValue: false) bool productHeaderImageRejected,
      int lastPlaybackProgress,
      @JsonKey(defaultValue: false) bool isDynamicReplyButtonMsg,
      @JsonKey(defaultValue: false) bool isMdHistoryMsg,
      int stickerSentTs,
      @JsonKey(defaultValue: false) bool requiresDirectConnection,
      @JsonKey(defaultValue: false) bool pttForwardedFeaturesEnabled,
      String caption});

  $MessageIdCopyWith<$Res>? get id;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? body = null,
    Object? type = null,
    Object? t = null,
    Object? notifyName = null,
    Object? from = null,
    Object? to = null,
    Object? isNewMsg = null,
    Object? star = null,
    Object? kicNotified = null,
    Object? recvFresh = null,
    Object? isFromTemplate = null,
    Object? pollInvalidated = null,
    Object? broadcast = null,
    Object? isForwarded = null,
    Object? hasReaction = null,
    Object? ephemeralOutOfSync = null,
    Object? productHeaderImageRejected = null,
    Object? lastPlaybackProgress = null,
    Object? isDynamicReplyButtonMsg = null,
    Object? isMdHistoryMsg = null,
    Object? stickerSentTs = null,
    Object? requiresDirectConnection = null,
    Object? pttForwardedFeaturesEnabled = null,
    Object? caption = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as MessageId?,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as int,
      notifyName: null == notifyName
          ? _value.notifyName
          : notifyName // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      isNewMsg: null == isNewMsg
          ? _value.isNewMsg
          : isNewMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as bool,
      kicNotified: null == kicNotified
          ? _value.kicNotified
          : kicNotified // ignore: cast_nullable_to_non_nullable
              as bool,
      recvFresh: null == recvFresh
          ? _value.recvFresh
          : recvFresh // ignore: cast_nullable_to_non_nullable
              as bool,
      isFromTemplate: null == isFromTemplate
          ? _value.isFromTemplate
          : isFromTemplate // ignore: cast_nullable_to_non_nullable
              as bool,
      pollInvalidated: null == pollInvalidated
          ? _value.pollInvalidated
          : pollInvalidated // ignore: cast_nullable_to_non_nullable
              as bool,
      broadcast: null == broadcast
          ? _value.broadcast
          : broadcast // ignore: cast_nullable_to_non_nullable
              as bool,
      isForwarded: null == isForwarded
          ? _value.isForwarded
          : isForwarded // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReaction: null == hasReaction
          ? _value.hasReaction
          : hasReaction // ignore: cast_nullable_to_non_nullable
              as bool,
      ephemeralOutOfSync: null == ephemeralOutOfSync
          ? _value.ephemeralOutOfSync
          : ephemeralOutOfSync // ignore: cast_nullable_to_non_nullable
              as bool,
      productHeaderImageRejected: null == productHeaderImageRejected
          ? _value.productHeaderImageRejected
          : productHeaderImageRejected // ignore: cast_nullable_to_non_nullable
              as bool,
      lastPlaybackProgress: null == lastPlaybackProgress
          ? _value.lastPlaybackProgress
          : lastPlaybackProgress // ignore: cast_nullable_to_non_nullable
              as int,
      isDynamicReplyButtonMsg: null == isDynamicReplyButtonMsg
          ? _value.isDynamicReplyButtonMsg
          : isDynamicReplyButtonMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      isMdHistoryMsg: null == isMdHistoryMsg
          ? _value.isMdHistoryMsg
          : isMdHistoryMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      stickerSentTs: null == stickerSentTs
          ? _value.stickerSentTs
          : stickerSentTs // ignore: cast_nullable_to_non_nullable
              as int,
      requiresDirectConnection: null == requiresDirectConnection
          ? _value.requiresDirectConnection
          : requiresDirectConnection // ignore: cast_nullable_to_non_nullable
              as bool,
      pttForwardedFeaturesEnabled: null == pttForwardedFeaturesEnabled
          ? _value.pttForwardedFeaturesEnabled
          : pttForwardedFeaturesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageIdCopyWith<$Res>? get id {
    if (_value.id == null) {
      return null;
    }

    return $MessageIdCopyWith<$Res>(_value.id!, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageId? id,
      String body,
      String type,
      int t,
      String notifyName,
      String from,
      String to,
      @JsonKey(defaultValue: false) bool isNewMsg,
      @JsonKey(defaultValue: false) bool star,
      @JsonKey(defaultValue: false) bool kicNotified,
      @JsonKey(defaultValue: false) bool recvFresh,
      @JsonKey(defaultValue: false) bool isFromTemplate,
      @JsonKey(defaultValue: false) bool pollInvalidated,
      @JsonKey(defaultValue: false) bool broadcast,
      @JsonKey(defaultValue: false) bool isForwarded,
      @JsonKey(defaultValue: false) bool hasReaction,
      @JsonKey(defaultValue: false) bool ephemeralOutOfSync,
      @JsonKey(defaultValue: false) bool productHeaderImageRejected,
      int lastPlaybackProgress,
      @JsonKey(defaultValue: false) bool isDynamicReplyButtonMsg,
      @JsonKey(defaultValue: false) bool isMdHistoryMsg,
      int stickerSentTs,
      @JsonKey(defaultValue: false) bool requiresDirectConnection,
      @JsonKey(defaultValue: false) bool pttForwardedFeaturesEnabled,
      String caption});

  @override
  $MessageIdCopyWith<$Res>? get id;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? body = null,
    Object? type = null,
    Object? t = null,
    Object? notifyName = null,
    Object? from = null,
    Object? to = null,
    Object? isNewMsg = null,
    Object? star = null,
    Object? kicNotified = null,
    Object? recvFresh = null,
    Object? isFromTemplate = null,
    Object? pollInvalidated = null,
    Object? broadcast = null,
    Object? isForwarded = null,
    Object? hasReaction = null,
    Object? ephemeralOutOfSync = null,
    Object? productHeaderImageRejected = null,
    Object? lastPlaybackProgress = null,
    Object? isDynamicReplyButtonMsg = null,
    Object? isMdHistoryMsg = null,
    Object? stickerSentTs = null,
    Object? requiresDirectConnection = null,
    Object? pttForwardedFeaturesEnabled = null,
    Object? caption = null,
  }) {
    return _then(_$MessageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as MessageId?,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as int,
      notifyName: null == notifyName
          ? _value.notifyName
          : notifyName // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      isNewMsg: null == isNewMsg
          ? _value.isNewMsg
          : isNewMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      star: null == star
          ? _value.star
          : star // ignore: cast_nullable_to_non_nullable
              as bool,
      kicNotified: null == kicNotified
          ? _value.kicNotified
          : kicNotified // ignore: cast_nullable_to_non_nullable
              as bool,
      recvFresh: null == recvFresh
          ? _value.recvFresh
          : recvFresh // ignore: cast_nullable_to_non_nullable
              as bool,
      isFromTemplate: null == isFromTemplate
          ? _value.isFromTemplate
          : isFromTemplate // ignore: cast_nullable_to_non_nullable
              as bool,
      pollInvalidated: null == pollInvalidated
          ? _value.pollInvalidated
          : pollInvalidated // ignore: cast_nullable_to_non_nullable
              as bool,
      broadcast: null == broadcast
          ? _value.broadcast
          : broadcast // ignore: cast_nullable_to_non_nullable
              as bool,
      isForwarded: null == isForwarded
          ? _value.isForwarded
          : isForwarded // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReaction: null == hasReaction
          ? _value.hasReaction
          : hasReaction // ignore: cast_nullable_to_non_nullable
              as bool,
      ephemeralOutOfSync: null == ephemeralOutOfSync
          ? _value.ephemeralOutOfSync
          : ephemeralOutOfSync // ignore: cast_nullable_to_non_nullable
              as bool,
      productHeaderImageRejected: null == productHeaderImageRejected
          ? _value.productHeaderImageRejected
          : productHeaderImageRejected // ignore: cast_nullable_to_non_nullable
              as bool,
      lastPlaybackProgress: null == lastPlaybackProgress
          ? _value.lastPlaybackProgress
          : lastPlaybackProgress // ignore: cast_nullable_to_non_nullable
              as int,
      isDynamicReplyButtonMsg: null == isDynamicReplyButtonMsg
          ? _value.isDynamicReplyButtonMsg
          : isDynamicReplyButtonMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      isMdHistoryMsg: null == isMdHistoryMsg
          ? _value.isMdHistoryMsg
          : isMdHistoryMsg // ignore: cast_nullable_to_non_nullable
              as bool,
      stickerSentTs: null == stickerSentTs
          ? _value.stickerSentTs
          : stickerSentTs // ignore: cast_nullable_to_non_nullable
              as int,
      requiresDirectConnection: null == requiresDirectConnection
          ? _value.requiresDirectConnection
          : requiresDirectConnection // ignore: cast_nullable_to_non_nullable
              as bool,
      pttForwardedFeaturesEnabled: null == pttForwardedFeaturesEnabled
          ? _value.pttForwardedFeaturesEnabled
          : pttForwardedFeaturesEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.id,
      required this.body,
      required this.type,
      required this.t,
      required this.notifyName,
      required this.from,
      required this.to,
      @JsonKey(defaultValue: false) required this.isNewMsg,
      @JsonKey(defaultValue: false) required this.star,
      @JsonKey(defaultValue: false) required this.kicNotified,
      @JsonKey(defaultValue: false) required this.recvFresh,
      @JsonKey(defaultValue: false) required this.isFromTemplate,
      @JsonKey(defaultValue: false) required this.pollInvalidated,
      @JsonKey(defaultValue: false) required this.broadcast,
      @JsonKey(defaultValue: false) required this.isForwarded,
      @JsonKey(defaultValue: false) required this.hasReaction,
      @JsonKey(defaultValue: false) required this.ephemeralOutOfSync,
      @JsonKey(defaultValue: false) required this.productHeaderImageRejected,
      required this.lastPlaybackProgress,
      @JsonKey(defaultValue: false) required this.isDynamicReplyButtonMsg,
      @JsonKey(defaultValue: false) required this.isMdHistoryMsg,
      required this.stickerSentTs,
      @JsonKey(defaultValue: false) required this.requiresDirectConnection,
      @JsonKey(defaultValue: false) required this.pttForwardedFeaturesEnabled,
      required this.caption});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final MessageId? id;
  @override
  final String body;
  @override
  final String type;
  @override
  final int t;
  @override
  final String notifyName;
  @override
  final String from;
  @override
  final String to;
  @override
  @JsonKey(defaultValue: false)
  final bool isNewMsg;
  @override
  @JsonKey(defaultValue: false)
  final bool star;
  @override
  @JsonKey(defaultValue: false)
  final bool kicNotified;
  @override
  @JsonKey(defaultValue: false)
  final bool recvFresh;
  @override
  @JsonKey(defaultValue: false)
  final bool isFromTemplate;
  @override
  @JsonKey(defaultValue: false)
  final bool pollInvalidated;
  @override
  @JsonKey(defaultValue: false)
  final bool broadcast;
  @override
  @JsonKey(defaultValue: false)
  final bool isForwarded;
  @override
  @JsonKey(defaultValue: false)
  final bool hasReaction;
  @override
  @JsonKey(defaultValue: false)
  final bool ephemeralOutOfSync;
  @override
  @JsonKey(defaultValue: false)
  final bool productHeaderImageRejected;
  @override
  final int lastPlaybackProgress;
  @override
  @JsonKey(defaultValue: false)
  final bool isDynamicReplyButtonMsg;
  @override
  @JsonKey(defaultValue: false)
  final bool isMdHistoryMsg;
  @override
  final int stickerSentTs;
  @override
  @JsonKey(defaultValue: false)
  final bool requiresDirectConnection;
  @override
  @JsonKey(defaultValue: false)
  final bool pttForwardedFeaturesEnabled;
  @override
  final String caption;

  @override
  String toString() {
    return 'Message(id: $id, body: $body, type: $type, t: $t, notifyName: $notifyName, from: $from, to: $to, isNewMsg: $isNewMsg, star: $star, kicNotified: $kicNotified, recvFresh: $recvFresh, isFromTemplate: $isFromTemplate, pollInvalidated: $pollInvalidated, broadcast: $broadcast, isForwarded: $isForwarded, hasReaction: $hasReaction, ephemeralOutOfSync: $ephemeralOutOfSync, productHeaderImageRejected: $productHeaderImageRejected, lastPlaybackProgress: $lastPlaybackProgress, isDynamicReplyButtonMsg: $isDynamicReplyButtonMsg, isMdHistoryMsg: $isMdHistoryMsg, stickerSentTs: $stickerSentTs, requiresDirectConnection: $requiresDirectConnection, pttForwardedFeaturesEnabled: $pttForwardedFeaturesEnabled, caption: $caption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.t, t) || other.t == t) &&
            (identical(other.notifyName, notifyName) ||
                other.notifyName == notifyName) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.isNewMsg, isNewMsg) ||
                other.isNewMsg == isNewMsg) &&
            (identical(other.star, star) || other.star == star) &&
            (identical(other.kicNotified, kicNotified) ||
                other.kicNotified == kicNotified) &&
            (identical(other.recvFresh, recvFresh) ||
                other.recvFresh == recvFresh) &&
            (identical(other.isFromTemplate, isFromTemplate) ||
                other.isFromTemplate == isFromTemplate) &&
            (identical(other.pollInvalidated, pollInvalidated) ||
                other.pollInvalidated == pollInvalidated) &&
            (identical(other.broadcast, broadcast) ||
                other.broadcast == broadcast) &&
            (identical(other.isForwarded, isForwarded) ||
                other.isForwarded == isForwarded) &&
            (identical(other.hasReaction, hasReaction) ||
                other.hasReaction == hasReaction) &&
            (identical(other.ephemeralOutOfSync, ephemeralOutOfSync) ||
                other.ephemeralOutOfSync == ephemeralOutOfSync) &&
            (identical(other.productHeaderImageRejected,
                    productHeaderImageRejected) ||
                other.productHeaderImageRejected ==
                    productHeaderImageRejected) &&
            (identical(other.lastPlaybackProgress, lastPlaybackProgress) ||
                other.lastPlaybackProgress == lastPlaybackProgress) &&
            (identical(
                    other.isDynamicReplyButtonMsg, isDynamicReplyButtonMsg) ||
                other.isDynamicReplyButtonMsg == isDynamicReplyButtonMsg) &&
            (identical(other.isMdHistoryMsg, isMdHistoryMsg) ||
                other.isMdHistoryMsg == isMdHistoryMsg) &&
            (identical(other.stickerSentTs, stickerSentTs) ||
                other.stickerSentTs == stickerSentTs) &&
            (identical(
                    other.requiresDirectConnection, requiresDirectConnection) ||
                other.requiresDirectConnection == requiresDirectConnection) &&
            (identical(other.pttForwardedFeaturesEnabled,
                    pttForwardedFeaturesEnabled) ||
                other.pttForwardedFeaturesEnabled ==
                    pttForwardedFeaturesEnabled) &&
            (identical(other.caption, caption) || other.caption == caption));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        body,
        type,
        t,
        notifyName,
        from,
        to,
        isNewMsg,
        star,
        kicNotified,
        recvFresh,
        isFromTemplate,
        pollInvalidated,
        broadcast,
        isForwarded,
        hasReaction,
        ephemeralOutOfSync,
        productHeaderImageRejected,
        lastPlaybackProgress,
        isDynamicReplyButtonMsg,
        isMdHistoryMsg,
        stickerSentTs,
        requiresDirectConnection,
        pttForwardedFeaturesEnabled,
        caption
      ]);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final MessageId? id,
      required final String body,
      required final String type,
      required final int t,
      required final String notifyName,
      required final String from,
      required final String to,
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
      required final int lastPlaybackProgress,
      @JsonKey(defaultValue: false) required final bool isDynamicReplyButtonMsg,
      @JsonKey(defaultValue: false) required final bool isMdHistoryMsg,
      required final int stickerSentTs,
      @JsonKey(defaultValue: false)
      required final bool requiresDirectConnection,
      @JsonKey(defaultValue: false)
      required final bool pttForwardedFeaturesEnabled,
      required final String caption}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  MessageId? get id;
  @override
  String get body;
  @override
  String get type;
  @override
  int get t;
  @override
  String get notifyName;
  @override
  String get from;
  @override
  String get to;
  @override
  @JsonKey(defaultValue: false)
  bool get isNewMsg;
  @override
  @JsonKey(defaultValue: false)
  bool get star;
  @override
  @JsonKey(defaultValue: false)
  bool get kicNotified;
  @override
  @JsonKey(defaultValue: false)
  bool get recvFresh;
  @override
  @JsonKey(defaultValue: false)
  bool get isFromTemplate;
  @override
  @JsonKey(defaultValue: false)
  bool get pollInvalidated;
  @override
  @JsonKey(defaultValue: false)
  bool get broadcast;
  @override
  @JsonKey(defaultValue: false)
  bool get isForwarded;
  @override
  @JsonKey(defaultValue: false)
  bool get hasReaction;
  @override
  @JsonKey(defaultValue: false)
  bool get ephemeralOutOfSync;
  @override
  @JsonKey(defaultValue: false)
  bool get productHeaderImageRejected;
  @override
  int get lastPlaybackProgress;
  @override
  @JsonKey(defaultValue: false)
  bool get isDynamicReplyButtonMsg;
  @override
  @JsonKey(defaultValue: false)
  bool get isMdHistoryMsg;
  @override
  int get stickerSentTs;
  @override
  @JsonKey(defaultValue: false)
  bool get requiresDirectConnection;
  @override
  @JsonKey(defaultValue: false)
  bool get pttForwardedFeaturesEnabled;
  @override
  String get caption;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageId _$MessageIdFromJson(Map<String, dynamic> json) {
  return _MessageId.fromJson(json);
}

/// @nodoc
mixin _$MessageId {
  @JsonKey(defaultValue: false)
  bool get fromMe => throw _privateConstructorUsedError;
  String get remote => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: '_serialized')
  String get serialized => throw _privateConstructorUsedError;

  /// Serializes this MessageId to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageIdCopyWith<MessageId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageIdCopyWith<$Res> {
  factory $MessageIdCopyWith(MessageId value, $Res Function(MessageId) then) =
      _$MessageIdCopyWithImpl<$Res, MessageId>;
  @useResult
  $Res call(
      {@JsonKey(defaultValue: false) bool fromMe,
      String remote,
      String id,
      @JsonKey(name: '_serialized') String serialized});
}

/// @nodoc
class _$MessageIdCopyWithImpl<$Res, $Val extends MessageId>
    implements $MessageIdCopyWith<$Res> {
  _$MessageIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromMe = null,
    Object? remote = null,
    Object? id = null,
    Object? serialized = null,
  }) {
    return _then(_value.copyWith(
      fromMe: null == fromMe
          ? _value.fromMe
          : fromMe // ignore: cast_nullable_to_non_nullable
              as bool,
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serialized: null == serialized
          ? _value.serialized
          : serialized // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageIdImplCopyWith<$Res>
    implements $MessageIdCopyWith<$Res> {
  factory _$$MessageIdImplCopyWith(
          _$MessageIdImpl value, $Res Function(_$MessageIdImpl) then) =
      __$$MessageIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(defaultValue: false) bool fromMe,
      String remote,
      String id,
      @JsonKey(name: '_serialized') String serialized});
}

/// @nodoc
class __$$MessageIdImplCopyWithImpl<$Res>
    extends _$MessageIdCopyWithImpl<$Res, _$MessageIdImpl>
    implements _$$MessageIdImplCopyWith<$Res> {
  __$$MessageIdImplCopyWithImpl(
      _$MessageIdImpl _value, $Res Function(_$MessageIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromMe = null,
    Object? remote = null,
    Object? id = null,
    Object? serialized = null,
  }) {
    return _then(_$MessageIdImpl(
      fromMe: null == fromMe
          ? _value.fromMe
          : fromMe // ignore: cast_nullable_to_non_nullable
              as bool,
      remote: null == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serialized: null == serialized
          ? _value.serialized
          : serialized // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageIdImpl implements _MessageId {
  const _$MessageIdImpl(
      {@JsonKey(defaultValue: false) required this.fromMe,
      required this.remote,
      required this.id,
      @JsonKey(name: '_serialized') required this.serialized});

  factory _$MessageIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageIdImplFromJson(json);

  @override
  @JsonKey(defaultValue: false)
  final bool fromMe;
  @override
  final String remote;
  @override
  final String id;
  @override
  @JsonKey(name: '_serialized')
  final String serialized;

  @override
  String toString() {
    return 'MessageId(fromMe: $fromMe, remote: $remote, id: $id, serialized: $serialized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageIdImpl &&
            (identical(other.fromMe, fromMe) || other.fromMe == fromMe) &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serialized, serialized) ||
                other.serialized == serialized));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fromMe, remote, id, serialized);

  /// Create a copy of MessageId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageIdImplCopyWith<_$MessageIdImpl> get copyWith =>
      __$$MessageIdImplCopyWithImpl<_$MessageIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageIdImplToJson(
      this,
    );
  }
}

abstract class _MessageId implements MessageId {
  const factory _MessageId(
          {@JsonKey(defaultValue: false) required final bool fromMe,
          required final String remote,
          required final String id,
          @JsonKey(name: '_serialized') required final String serialized}) =
      _$MessageIdImpl;

  factory _MessageId.fromJson(Map<String, dynamic> json) =
      _$MessageIdImpl.fromJson;

  @override
  @JsonKey(defaultValue: false)
  bool get fromMe;
  @override
  String get remote;
  @override
  String get id;
  @override
  @JsonKey(name: '_serialized')
  String get serialized;

  /// Create a copy of MessageId
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageIdImplCopyWith<_$MessageIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallEvent _$CallEventFromJson(Map<String, dynamic> json) {
  return _CallEvent.fromJson(json);
}

/// @nodoc
mixin _$CallEvent {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isGroup => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get isVideo => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 0)
  int get offerTime => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get peerJid => throw _privateConstructorUsedError;

  /// Serializes this CallEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallEventCopyWith<CallEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEventCopyWith<$Res> {
  factory $CallEventCopyWith(CallEvent value, $Res Function(CallEvent) then) =
      _$CallEventCopyWithImpl<$Res, CallEvent>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(defaultValue: false) bool isGroup,
      @JsonKey(defaultValue: false) bool isVideo,
      @JsonKey(defaultValue: 0) int offerTime,
      String sender,
      String peerJid});
}

/// @nodoc
class _$CallEventCopyWithImpl<$Res, $Val extends CallEvent>
    implements $CallEventCopyWith<$Res> {
  _$CallEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isGroup = null,
    Object? isVideo = null,
    Object? offerTime = null,
    Object? sender = null,
    Object? peerJid = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideo: null == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool,
      offerTime: null == offerTime
          ? _value.offerTime
          : offerTime // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      peerJid: null == peerJid
          ? _value.peerJid
          : peerJid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallEventImplCopyWith<$Res>
    implements $CallEventCopyWith<$Res> {
  factory _$$CallEventImplCopyWith(
          _$CallEventImpl value, $Res Function(_$CallEventImpl) then) =
      __$$CallEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(defaultValue: false) bool isGroup,
      @JsonKey(defaultValue: false) bool isVideo,
      @JsonKey(defaultValue: 0) int offerTime,
      String sender,
      String peerJid});
}

/// @nodoc
class __$$CallEventImplCopyWithImpl<$Res>
    extends _$CallEventCopyWithImpl<$Res, _$CallEventImpl>
    implements _$$CallEventImplCopyWith<$Res> {
  __$$CallEventImplCopyWithImpl(
      _$CallEventImpl _value, $Res Function(_$CallEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isGroup = null,
    Object? isVideo = null,
    Object? offerTime = null,
    Object? sender = null,
    Object? peerJid = null,
  }) {
    return _then(_$CallEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideo: null == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool,
      offerTime: null == offerTime
          ? _value.offerTime
          : offerTime // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      peerJid: null == peerJid
          ? _value.peerJid
          : peerJid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallEventImpl implements _CallEvent {
  const _$CallEventImpl(
      {required this.id,
      @JsonKey(defaultValue: false) required this.isGroup,
      @JsonKey(defaultValue: false) required this.isVideo,
      @JsonKey(defaultValue: 0) required this.offerTime,
      required this.sender,
      required this.peerJid});

  factory _$CallEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallEventImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(defaultValue: false)
  final bool isGroup;
  @override
  @JsonKey(defaultValue: false)
  final bool isVideo;
  @override
  @JsonKey(defaultValue: 0)
  final int offerTime;
  @override
  final String sender;
  @override
  final String peerJid;

  @override
  String toString() {
    return 'CallEvent(id: $id, isGroup: $isGroup, isVideo: $isVideo, offerTime: $offerTime, sender: $sender, peerJid: $peerJid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo) &&
            (identical(other.offerTime, offerTime) ||
                other.offerTime == offerTime) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.peerJid, peerJid) || other.peerJid == peerJid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, isGroup, isVideo, offerTime, sender, peerJid);

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallEventImplCopyWith<_$CallEventImpl> get copyWith =>
      __$$CallEventImplCopyWithImpl<_$CallEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallEventImplToJson(
      this,
    );
  }
}

abstract class _CallEvent implements CallEvent {
  const factory _CallEvent(
      {required final String id,
      @JsonKey(defaultValue: false) required final bool isGroup,
      @JsonKey(defaultValue: false) required final bool isVideo,
      @JsonKey(defaultValue: 0) required final int offerTime,
      required final String sender,
      required final String peerJid}) = _$CallEventImpl;

  factory _CallEvent.fromJson(Map<String, dynamic> json) =
      _$CallEventImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(defaultValue: false)
  bool get isGroup;
  @override
  @JsonKey(defaultValue: false)
  bool get isVideo;
  @override
  @JsonKey(defaultValue: 0)
  int get offerTime;
  @override
  String get sender;
  @override
  String get peerJid;

  /// Create a copy of CallEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallEventImplCopyWith<_$CallEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QrCodeImage _$QrCodeImageFromJson(Map<String, dynamic> json) {
  return _QrCodeImage.fromJson(json);
}

/// @nodoc
mixin _$QrCodeImage {
  String? get urlCode => throw _privateConstructorUsedError;
  String? get base64Image => throw _privateConstructorUsedError;

  /// Serializes this QrCodeImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrCodeImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrCodeImageCopyWith<QrCodeImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrCodeImageCopyWith<$Res> {
  factory $QrCodeImageCopyWith(
          QrCodeImage value, $Res Function(QrCodeImage) then) =
      _$QrCodeImageCopyWithImpl<$Res, QrCodeImage>;
  @useResult
  $Res call({String? urlCode, String? base64Image});
}

/// @nodoc
class _$QrCodeImageCopyWithImpl<$Res, $Val extends QrCodeImage>
    implements $QrCodeImageCopyWith<$Res> {
  _$QrCodeImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrCodeImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlCode = freezed,
    Object? base64Image = freezed,
  }) {
    return _then(_value.copyWith(
      urlCode: freezed == urlCode
          ? _value.urlCode
          : urlCode // ignore: cast_nullable_to_non_nullable
              as String?,
      base64Image: freezed == base64Image
          ? _value.base64Image
          : base64Image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrCodeImageImplCopyWith<$Res>
    implements $QrCodeImageCopyWith<$Res> {
  factory _$$QrCodeImageImplCopyWith(
          _$QrCodeImageImpl value, $Res Function(_$QrCodeImageImpl) then) =
      __$$QrCodeImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? urlCode, String? base64Image});
}

/// @nodoc
class __$$QrCodeImageImplCopyWithImpl<$Res>
    extends _$QrCodeImageCopyWithImpl<$Res, _$QrCodeImageImpl>
    implements _$$QrCodeImageImplCopyWith<$Res> {
  __$$QrCodeImageImplCopyWithImpl(
      _$QrCodeImageImpl _value, $Res Function(_$QrCodeImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrCodeImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlCode = freezed,
    Object? base64Image = freezed,
  }) {
    return _then(_$QrCodeImageImpl(
      urlCode: freezed == urlCode
          ? _value.urlCode
          : urlCode // ignore: cast_nullable_to_non_nullable
              as String?,
      base64Image: freezed == base64Image
          ? _value.base64Image
          : base64Image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QrCodeImageImpl implements _QrCodeImage {
  const _$QrCodeImageImpl({this.urlCode, this.base64Image});

  factory _$QrCodeImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrCodeImageImplFromJson(json);

  @override
  final String? urlCode;
  @override
  final String? base64Image;

  @override
  String toString() {
    return 'QrCodeImage(urlCode: $urlCode, base64Image: $base64Image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrCodeImageImpl &&
            (identical(other.urlCode, urlCode) || other.urlCode == urlCode) &&
            (identical(other.base64Image, base64Image) ||
                other.base64Image == base64Image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, urlCode, base64Image);

  /// Create a copy of QrCodeImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrCodeImageImplCopyWith<_$QrCodeImageImpl> get copyWith =>
      __$$QrCodeImageImplCopyWithImpl<_$QrCodeImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrCodeImageImplToJson(
      this,
    );
  }
}

abstract class _QrCodeImage implements QrCodeImage {
  const factory _QrCodeImage(
      {final String? urlCode, final String? base64Image}) = _$QrCodeImageImpl;

  factory _QrCodeImage.fromJson(Map<String, dynamic> json) =
      _$QrCodeImageImpl.fromJson;

  @override
  String? get urlCode;
  @override
  String? get base64Image;

  /// Create a copy of QrCodeImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrCodeImageImplCopyWith<_$QrCodeImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
