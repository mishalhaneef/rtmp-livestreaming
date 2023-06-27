import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livestream/features/live_view/model/message_model.dart';

class LiveViewController extends ChangeNotifier {
  List<MessageModel> messages = [];
  TextEditingController textController = TextEditingController();

  void handleSubmitted(String text, bool isDonation) {
    log('text : $text');
    if (text.isNotEmpty) {
      textController.clear();
      MessageModel message = MessageModel(
        message: text,
        isDonation: isDonation,
      );

      messages.insert(0, message);
      textController.clear();

      notifyListeners();
    }
  }
}
