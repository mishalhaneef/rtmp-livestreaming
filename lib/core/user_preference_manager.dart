import 'dart:developer';

import 'package:livestream/controller/user_base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class UserPreferenceManager {
  static Future<void> getUserDetails(UserController controller) async {
    final pref = await SharedPreferences.getInstance();
    final String? userID = pref.getString(PreferenceConstants.userID);
    if (userID != null) {
      log("user ID:${userID.toString()}");
      await controller.getUserDetails(userID);
    }
  }
}
