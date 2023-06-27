import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LiveController extends ChangeNotifier {
  bool isSwitch = false;
  bool goingLive = false;

  onButtonEnables(val) {
    isSwitch = val;
    if (val) {
      Fluttertoast.showToast(msg: 'Comment Enabled');
    } else {
      Fluttertoast.showToast(msg: 'Comment Disabled');
    }
    notifyListeners();
  }

  onGoLive() async {
    goingLive = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    Fluttertoast.showToast(msg: 'Live Server Not Found');
    goingLive = false;
    notifyListeners();
  }
}
