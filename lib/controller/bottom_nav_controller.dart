import 'package:flutter/material.dart';

class BottomNavigationBarController extends ChangeNotifier {
  int currentIndex = 0;

  changeScreen(int index) {
    currentIndex = index;
    notifyListeners();
  }
}