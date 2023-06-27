import 'package:flutter/material.dart';

class UserSearchController extends ChangeNotifier {
  bool isSearching = false;

  onSearch() {
    isSearching = true;
    notifyListeners();
  }
}
