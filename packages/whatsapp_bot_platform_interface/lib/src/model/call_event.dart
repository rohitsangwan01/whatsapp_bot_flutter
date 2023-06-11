class CallEvent {
  CallEvent({
    required this.id,
    required this.isGroup,
    required this.isVideo,
    required this.offerTime,
    required this.sender,
    required this.peerJid,
  });

  final String id;
  final bool isGroup;
  final bool isVideo;
  final int offerTime;
  final String sender;
  final String peerJid;

  CallEvent copyWith({
    String? id,
    bool? isGroup,
    bool? isVideo,
    int? offerTime,
    String? sender,
    String? peerJid,
  }) {
    return CallEvent(
      id: id ?? this.id,
      isGroup: isGroup ?? this.isGroup,
      isVideo: isVideo ?? this.isVideo,
      offerTime: offerTime ?? this.offerTime,
      sender: sender ?? this.sender,
      peerJid: peerJid ?? this.peerJid,
    );
  }

  factory CallEvent.fromJson(Map<String, dynamic> json) {
    return CallEvent(
      id: json["id"] ?? "",
      isGroup: json["isGroup"] ?? false,
      isVideo: json["isVideo"] ?? false,
      offerTime: json["offerTime"] ?? 0,
      sender: json["sender"] ?? "",
      peerJid: json["peerJid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "isGroup": isGroup,
        "isVideo": isVideo,
        "offerTime": offerTime,
        "sender": sender,
        "peerJid": peerJid,
      };
}
