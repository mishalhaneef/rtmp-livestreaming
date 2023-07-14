import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/features/live_view/model/live_watchers_model.dart';

class LiveViewController extends ChangeNotifier {
  BaseApiService baseApiService = BaseApiService();
  LiveViewersModel liveViewersModel = LiveViewersModel();
  int viewCount = 0;

  Future<void> getLiveViewCount(String streamerID) async {
    final response = await baseApiService.getApiCall(
      'http://108.175.11.224:8000/api/streams',
      disableBaseURL: true,
    );

    if (response != null) {
      Map<String, dynamic> res = json.decode(jsonEncode(response.data));

      // Get the "live" object
      Map<String, dynamic> live = res['live'];

      // Get the user ID object (e.g., "64b03d6213aa482fe19d8106")
      Map<String, dynamic> user = live.values.first;

      // Get the subscribers list
      List<dynamic> subscribers = user['subscribers'];

      // Get the length of the subscribers list
      viewCount = subscribers.length;

      notifyListeners();
    }
  }
}
