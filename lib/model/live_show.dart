// class Live {
//   final String id;
//   final String live;
//   final String user;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   Live({
//     required this.id,
//     required this.live,
//     required this.user,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory Live.fromJson(Map<String, dynamic> json) {
//     return Live(
//       id: json['_id'],
//       live: json['live'],
//       user: json['user'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       v: json['__v'],
//     );
//   }
// }
class Live {
  List<Lives>? lives;

  Live({this.lives});

  Live.fromJson(Map<String, dynamic> json) {
    if (json['lives'] != null) {
      lives = <Lives>[];
      json['lives'].forEach((v) {
        lives!.add(new Lives.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lives != null) {
      data['lives'] = this.lives!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lives {
  String? sId;
  String? live;
  User? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Lives(
      {this.sId,
      this.live,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Lives.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    live = json['live'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['live'] = this.live;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? username;
  String? email;
  String? password;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.name,
      this.username,
      this.email,
      this.password,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
