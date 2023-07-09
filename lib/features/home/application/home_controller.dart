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

  Stream<List<StreamModel>> getLiveStream() {
    return baseApiService.getApiCall(ApiEndPoints.lives).then((response) {
      if (response != null) {
        return streamFromJson(jsonEncode(response.data)) as List<StreamModel>;
      }
      return <StreamModel>[]; // Return an empty list if response is null
    }).catchError((error) {
      print('Error fetching live data: $error');
      return <StreamModel>[]; // Return an empty list in case of error
    }).asStream();
  }

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
