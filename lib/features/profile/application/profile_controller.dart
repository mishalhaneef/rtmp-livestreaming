import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker imagePicker = ImagePicker();

  File? image;

  Future<void> selectImage() async {
    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        log('imaged picked ${pickedImage.path}');
        image = File(pickedImage.path);
        notifyListeners();
      }
    } catch (e) {
      log('error picking image $e');
    }
  }

  cleareSelectedImage() {
    image = null;
    notifyListeners();
  }

  Future<void> saveEditedProfileData(String? userID) async {
    isFetching = true;
    notifyListeners();

    final multipartImage = await MultipartFile.fromFile(
      image!.path,
      filename: image!.path,
    );

    final body = {
      "username": usernameController.text,
      "name": fullnameController.text,
      "email": emailController.text,
      "image": multipartImage,
    };

    if (userID == null) {
      Fluttertoast.showToast(msg: 'Please try again, something went wrong');
    } else {
      final response = await baseApiService
          .avatarUploadApiCall('${ApiEndPoints.edit}$userID', body: body);
      // final response = await baseApiService.postApiCall(
      //   '${ApiEndPoints.edit}$userID',
      //   body: body,
      // );

      if (response != null) {
        log("repsonse : ${response.data}");
        Fluttertoast.showToast(msg: "Profile Updated");
      }
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
