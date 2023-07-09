class LiveStream {
  List<Subscriber> subscribers;

  LiveStream({required this.subscribers});
}

class Subscriber {
  String app;
  String stream;
  String clientId;
  DateTime connectCreated;
  int bytes;
  String ip;
  String protocol;

  Subscriber({
    required this.app,
    required this.stream,
    required this.clientId,
    required this.connectCreated,
    required this.bytes,
    required this.ip,
    required this.protocol,
  });
}

