import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? msg;
  UserData? user;

  UserModel({
    this.msg,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        msg: json["msg"],
        user: UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "user": user!.toJson(),
      };
}

class UserData {
  String? name;
  String? username;
  String? email;
  String? password;
  String? image;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserData({
    this.name,
    this.username,
    this.email,
    this.password,
    this.image,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "image": image,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
