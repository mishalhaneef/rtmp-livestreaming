import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/configs/api_end_points.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/authentication/model/login_repsone_model.dart';
import 'package:livestream/services/authentication/firebase/firebase_auth_fasade.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  BaseApiService baseApiService = BaseApiService();

  bool isSigned = false;
  bool isFetching = false;

  showLoadingIndicator() {
    isFetching = true;
    notifyListeners();
  }

  hideLoadingIndicator() {
    isFetching = false;
    notifyListeners();
  }

  Future<bool> loginWIthEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (email.isEmpty) {
        Fluttertoast.showToast(msg: 'Enter Email');
      } else if (password.isEmpty) {
        Fluttertoast.showToast(msg: 'Enter Password');
      } else {
        final userCredential = await firebaseAuthService
            .signinWithEmailAndPassword(email, password);

        if (userCredential != null) {
          final body = {
            "username": email,
            "password": password,
          };
          final response =
              await baseApiService.postApiCall(ApiEndPoints.login, body: body);
          if (response != null) {
            log('response ; ${response.data}');
            final pref = await SharedPreferences.getInstance();

            await pref.setString(
              PreferenceConstants.userID,
              LoginResponseModel.fromJson(response.data).user!.sId!,
            );

            notifyListeners();
            return true;
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> registerWithEmailAndPassword(
    String username,
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuthService
          .registerWithEmailAndPassword(email, password);
      if (userCredential != null) {
        final body = {
          "username": username,
          "email": email,
          "name": fullName,
          "password": password,
        };
        final response =
            await baseApiService.postApiCall(ApiEndPoints.register, body: body);
        if (response != null) {
          final pref = await SharedPreferences.getInstance();
           final loginResponseModel = LoginResponseModel.fromJson(response.data);

          Fluttertoast.showToast(msg: loginResponseModel.msg ?? "");

          await pref.setString(
            PreferenceConstants.userID,
            loginResponseModel.user!.sId!,
          );
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
