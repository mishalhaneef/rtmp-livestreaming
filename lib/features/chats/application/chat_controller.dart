import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livestream/features/chats/model/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  TextEditingController textController = TextEditingController();

  List<ChatMessage> messages = [];
  bool sendMessage = false;
  bool isFetching = false;

  void handleSendMessage(String text) {
    if (text.isNotEmpty) {
      log('not empty');
      textController.clear();
      ChatMessage chatMessage = ChatMessage(
        message: text,
        isMe: true,
        time: DateFormat('h:mm a').format(DateTime.now()),
      );
      messages.insert(0, chatMessage);
      sendMessage = false;
      notifyListeners();
    }
  }
}
