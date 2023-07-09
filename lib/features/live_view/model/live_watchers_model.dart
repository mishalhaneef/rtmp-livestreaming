class LiveStreamViewrsModel {
  List<Subscriber>? subscribers;

  LiveStreamViewrsModel({this.subscribers});

  factory LiveStreamViewrsModel.fromJson(Map<String, dynamic> json) {
    return LiveStreamViewrsModel(
      subscribers: (json['64a437ee1e15b6e8bb574053']['live']['subscribers']
              as List<dynamic>)
          .map((sub) => Subscriber.fromJson(sub))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '64a437ee1e15b6e8bb574053': {
        'live': {
          'subscribers': subscribers?.map((sub) => sub.toJson()).toList(),
        },
      },
    };
  }
}

class Subscriber {
  String? app;
  String? stream;
  String? clientId;
  DateTime? connectCreated;
  int? bytes;
  String? ip;
  String? protocol;

  Subscriber({
    this.app,
    this.stream,
    this.clientId,
    this.connectCreated,
    this.bytes,
    this.ip,
    this.protocol,
  });

  factory Subscriber.fromJson(Map<String, dynamic> json) {
    return Subscriber(
      app: json['app'],
      stream: json['stream'],
      clientId: json['clientId'],
      connectCreated: DateTime.parse(json['connectCreated']),
      bytes: json['bytes'],
      ip: json['ip'],
      protocol: json['protocol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app': app,
      'stream': stream,
      'clientId': clientId,
      'connectCreated': connectCreated?.toIso8601String(),
      'bytes': bytes,
      'ip': ip,
      'protocol': protocol,
    };
  }
}
