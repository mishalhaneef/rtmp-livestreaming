import 'dart:convert';

StreamModel streamFromJson(String str) =>
    StreamModel.fromJson(json.decode(str));

String streamToJson(StreamModel data) => json.encode(data.toJson());

class StreamModel {
  List<Live>? lives;

  StreamModel({
    this.lives,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
        lives: List<Live>.from(json["lives"].map((x) => Live.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lives": List<dynamic>.from(lives!.map((x) => x.toJson())),
      };
}

class Live {
  String? id;
  String? live;
  User? user;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Live({
    this.id,
    this.live,
    this.user,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        id: json["_id"],
        live: json["live"],
        user: User.fromJson(json["user"]),
        url: json["url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "live": live,
        "user": user!.toJson(),
        "url": url,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class User {
  String? id;
  String? name;
  String? username;
  String? email;
  String? password;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.password,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
