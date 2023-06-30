import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/configs/api_end_points.dart';
import 'package:livestream/features/search/model/search_model.dart';

class UserSearchController extends ChangeNotifier {
  bool isSearching = false;
  BaseApiService baseApiService = BaseApiService();
  SearchModel searchResult = SearchModel();

  Future<void> searchUsers(String userName) async {
    isSearching = true;
    notifyListeners();

    final response =
        await baseApiService.getApiCall('${ApiEndPoints.search}$userName');

    if (response != null) {
      log("response ; ${response.data}");
      searchResult = searchResultFromJson(jsonEncode(response.data));
    }
    isSearching = false;
    notifyListeners();
  }
}
