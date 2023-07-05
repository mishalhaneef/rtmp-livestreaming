import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/configs/api_end_points.dart';
import 'package:livestream/features/home/model/stream_model.dart';

class StreamDisplayController extends ChangeNotifier {
  bool isFetching = false;
  BaseApiService baseApiService = BaseApiService();
  StreamModel streamModel = StreamModel();

  Future<void> getLive() async {
    isFetching = true;
    notifyListeners();
    final response = await baseApiService.getApiCall(ApiEndPoints.lives);
    if (response != null) {
      streamModel = streamFromJson(jsonEncode(response.data));
    }
    isFetching = false;
    notifyListeners();
    log("response : $response");
  }
}
