import 'dart:developer';
import 'dart:io';
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
  // final ImagePicker _imagePicker = ImagePicker();

  static File? _image;

  File? get image => _image;

  // Future<void> selectImage() async {
  //   final pickedImage =
  //       await _imagePicker.getImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     _image = File(pickedImage.path);
  //     final bytes = await _image!.readAsBytes();
  //     final base64Image = base64Encode(bytes);

  //     notifyListeners();
  //   }
  // }

  Future<void> saveEditedProfileData(String? userID) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final imageBytes = await pickedImage!.readAsBytes();

    isFetching = true;
    notifyListeners();

    // final bytes = await _image!.readAsBytes();
    // final base64Image = base64Encode(bytes);
    // final bytes = await _image!.readAsBytes();
    // final base64Image = base64Encode(bytes);
    final body = {
      "username": usernameController.text,
      "name": fullnameController.text,
      "email": emailController.text,
      "image": imageBytes
    };

    log('body : $body');
    if (userID == null) {
      Fluttertoast.showToast(msg: 'Please try again, something went wrong');
    } else {
      // ignore: unnecessary_null_comparison
      if (pickedImage != null) {
        final response = await baseApiService.postApiCall(
          '${ApiEndPoints.edit}$userID',
          body: body,
        );
        if (response!.statusCode == 200) {
          // Image uploaded successfully
          print('Image uploaded!');
        }
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
