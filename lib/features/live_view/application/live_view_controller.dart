import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/features/live_view/model/live_watchers_model.dart';

class LiveViewController extends ChangeNotifier {
  BaseApiService baseApiService = BaseApiService();
  LiveStreamViewrsModel liveViewersModel = LiveStreamViewrsModel();
  int viewCount = 0;

  Future<void> getLiveViewCount(String streamerID) async {
    final response = await baseApiService.getApiCall(
      'http://108.175.11.224:8000/api/streams',
      disableBaseURL: true,
    );

    if (response != null) {
      log("repsonse : $response");
      // liveViewersModel = LiveStreamViewrsModel.fromJson(response.data);
      // log("after assignation : ${liveViewersModel.subscribers}");
      notifyListeners();
    }
  }
}
