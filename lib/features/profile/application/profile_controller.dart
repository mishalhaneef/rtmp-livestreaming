import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livestream/configs/api_base_service.dart';
import 'package:livestream/configs/api_end_points.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  Future<bool> saveEditedProfileData(UserData user) async {
    isFetching = true;
    notifyListeners();

    try {
      String? imageURL = user.image;

      if (image != null) {
        File imageFile = File(image!.path);
        String fileName = imageFile.path.split('/').last;

        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

        log("uploaded : ${uploadTask.snapshot.storage.app.name}");

        await uploadTask.whenComplete(() async {
          imageURL = await ref.getDownloadURL();
        });
      }

      final body = {
        "username": usernameController.text,
        "name": fullnameController.text,
        "email": emailController.text,
        "image": imageURL,
      };

      if (user.id == null) {
        Fluttertoast.showToast(msg: 'Please try again, something went wrong');
      } else {
        final response = await baseApiService
            .postApiCall('${ApiEndPoints.edit}${user.id}', body: body);

        if (response != null) {
          log("response: ${response.data}");
          Map<String, dynamic> res = json.decode(jsonEncode(response.data));

          String message = res['msg'];

          if (message == 'email_not_valid') {
            Fluttertoast.showToast(msg: "please check your email again");

            return false;
          } else {
            Fluttertoast.showToast(msg: "Profile Updated");
            return true;
          }
        }
      }
    } catch (e) {
      log("Error caught while saving edited profile");
      return false;
    } finally {
      isFetching = false;
      notifyListeners();
    }
    return false;
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
