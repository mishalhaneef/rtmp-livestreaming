import 'dart:convert';

import 'package:livestream/core/base_user_model.dart';

SearchModel searchResultFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchResultToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  List<UserData>? users;

  SearchModel({
    this.users,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        users:
            List<UserData>.from(json["users"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}
