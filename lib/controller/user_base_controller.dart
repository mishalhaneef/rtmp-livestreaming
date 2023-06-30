import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/core/base_user_model.dart';

import '../configs/api_end_points.dart';

class UserController extends ChangeNotifier {
  bool isFetching = false;
  BaseApiService baseApiService = BaseApiService();
  UserModel userModel = UserModel();

  showLoadingIndicator() {
    isFetching = true;
    notifyListeners();
  }

  hideLoadingIndicator() {
    isFetching = false;
    notifyListeners();
  }

  Future<void> getUserDetails(String userID) async {
    showLoadingIndicator();

    final response =
        await baseApiService.getApiCall('${ApiEndPoints.userDetails}$userID');

    if (response != null) {
      log('user details : ${response.data}');
      userModel = userModelFromJson(jsonEncode(response.data));
      log('user name from model : ${userModel.user!.name}');
    }

    hideLoadingIndicator();
  }
}
