import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/configs/api_end_points.dart';
import 'package:livestream/core/base_user_model.dart';

class ProfileController extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isFetching = false;
  BaseApiService baseApiService = BaseApiService();
  Map<String, dynamic> userData = {};

  Future<void> saveEditedProfileData(String? userID) async {
    isFetching = true;
    notifyListeners();

    final body = {
      "username": usernameController.text,
      "name": fullnameController.text,
      "email": emailController.text,
      "image": "image_link"
    };

    log('body : $body');
    if (userID == null) {
      Fluttertoast.showToast(msg: 'Please try again, something went wrong');
    } else {
      await baseApiService.postApiCall('${ApiEndPoints.edit}$userID',
          body: body);
    }

    isFetching = false;
    notifyListeners();
  }

  String getHintText(String settings, UserData user) {
    switch (settings) {
      case 'username':
        return user.username ?? 'Loading...';
      case 'fullname':
        return user.name ?? 'Loading...';
      case 'email':
        return user.email ?? 'Loading...';
      default:
        return '';
    }
  }

  Icon buildSuffixIcon(IconData icon) {
    return Icon(
      icon,
      size: 18,
      color: Colors.grey,
    );
  }

  TextEditingController getController(String settings) {
    switch (settings) {
      case 'username':
        return usernameController;
      case 'fullname':
        return fullnameController;
      case 'email':
        return emailController;
      default:
        return TextEditingController();
    }
  }
}
