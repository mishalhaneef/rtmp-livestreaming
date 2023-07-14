import 'dart:convert';

LiveViewersModel liveViewersFromJson(String str) =>
    LiveViewersModel.fromJson(json.decode(str));

String liveViewersToJson(LiveViewersModel data) => json.encode(data.toJson());

class LiveViewersModel {
  Map<String, LiveStream>? live;

  LiveViewersModel({
    this.live,
  });

  factory LiveViewersModel.fromJson(Map<String, dynamic> json) =>
      LiveViewersModel(
        live: Map.from(json['live']).map((key, value) =>
            MapEntry<String, LiveStream>(key, LiveStream.fromJson(value))),
      );

  Map<String, dynamic> toJson() => {
        "live": Map.from(live!).map(
            (key, value) => MapEntry<String, dynamic>(key, value.toJson())),
      };
}

class LiveStream {
  Publisher? publisher;
  List<Publisher>? subscribers;

  LiveStream({
    this.publisher,
    this.subscribers,
  });

  factory LiveStream.fromJson(Map<String, dynamic> json) => LiveStream(
        publisher: Publisher.fromJson(json["publisher"]),
        subscribers: List<Publisher>.from(
            json["subscribers"].map((x) => Publisher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "publisher": publisher!.toJson(),
        "subscribers": List<dynamic>.from(subscribers!.map((x) => x.toJson())),
      };
}

class Publisher {
  String? app;
  String? stream;
  String? clientId;
  DateTime? connectCreated;
  int? bytes;
  String? ip;
  Audio? audio;
  Video? video;
  String? protocol;

  Publisher({
    this.app,
    this.stream,
    this.clientId,
    this.connectCreated,
    this.bytes,
    this.ip,
    this.audio,
    this.video,
    this.protocol,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) => Publisher(
        app: json["app"],
        stream: json["stream"],
        clientId: json["clientId"],
        connectCreated: DateTime.parse(json["connectCreated"]),
        bytes: json["bytes"],
        ip: json["ip"],
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        protocol: json["protocol"],
      );

  Map<String, dynamic> toJson() => {
        "app": app,
        "stream": stream,
        "clientId": clientId,
        "connectCreated": connectCreated!.toIso8601String(),
        "bytes": bytes,
        "ip": ip,
        "audio": audio?.toJson(),
        "video": video?.toJson(),
        "protocol": protocol,
      };
}

class Audio {
  String? codec;
  String? profile;
  int? samplerate;
  int? channels;

  Audio({
    this.codec,
    this.profile,
    this.samplerate,
    this.channels,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        codec: json["codec"],
        profile: json["profile"],
        samplerate: json["samplerate"],
        channels: json["channels"],
      );

  Map<String, dynamic> toJson() => {
        "codec": codec,
        "profile": profile,
        "samplerate": samplerate,
        "channels": channels,
      };
}

class Video {
  String? codec;
  int? width;
  int? height;
  String? profile;
  double? level;
  int? fps;

  Video({
    this.codec,
    this.width,
    this.height,
    this.profile,
    this.level,
    this.fps,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        codec: json["codec"],
        width: json["width"],
        height: json["height"],
        profile: json["profile"],
        level: json["level"]?.toDouble(),
        fps: json["fps"],
      );

  Map<String, dynamic> toJson() => {
        "codec": codec,
        "width": width,
        "height": height,
        "profile": profile,
        "level": level,
        "fps": fps,
      };
}
