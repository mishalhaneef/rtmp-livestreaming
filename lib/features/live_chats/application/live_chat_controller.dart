import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:livestream/features/live_chats/model/live_chat_model.dart';

class LiveChatController extends ChangeNotifier {
  TextEditingController textController = TextEditingController();
  bool isFetching = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? collectionID;
  LiveMessageModel? message;

  List<LiveMessageModel> messagesList = [];

  int totalCount = 0;

  Future<void> createCollection(String? streamerName) async {
    log('calling');
    if (streamerName != null) {
      log('streamerName : $streamerName');

      try {
        isFetching = true;
        notifyListeners();
        CollectionReference messageCollection =
            firestore.collection(streamerName);
        // ? enable this code if any message needs to show as admin
        // ? after stream

        message = LiveMessageModel(
          username: 'vueflow',
          message: 'Welcome to Stream!',
          time: DateTime.now().millisecondsSinceEpoch,
        );

        DocumentReference documentRef =
            await messageCollection.add(message!.toMap());

        collectionID = documentRef.id;
        log('Collection ID: $collectionID');
        isFetching = false;
        notifyListeners();
      } catch (error) {
        isFetching = false;
        notifyListeners();
        log("Error on creating documents : $error");
      }
    } else {
      Fluttertoast.showToast(msg: 'Failed to fetch User Details');
    }
  }

  Future<void> sendChat(
      String username, String message, String streamerName, int time) async {
    textController.clear();

    messagesList.insert(
      0,
      LiveMessageModel(username: username, message: message, time: time),
    );

    notifyListeners();

    log("username :$username | message : $message | | streamname : $streamerName");
    await _addChatMessage(username, message, streamerName, time)
        .then((_) => log('Chat message added successfully'))
        .catchError((error) => log('Failed to add chat message: $error'));
  }

  Future<void> _addChatMessage(String username, String userMessage,
      String streamerName, int time) async {
    CollectionReference messageCollection = firestore.collection(streamerName);
    DocumentReference documentRef =
        messageCollection.doc(); // Generate a new document ID

    Map<String, dynamic> chatData = {
      'username': username,
      'message': userMessage,
      'time': time,
    };

    log('chat data : $chatData');

    await documentRef.set(chatData);
  }

  Future<void> fetchMessages(String streamerName,
      {bool sendChat = false}) async {
    if (!sendChat) {
      isFetching = true;
      notifyListeners();
    }
    messagesList.clear();
    CollectionReference messageCollection = firestore.collection(streamerName);
    QuerySnapshot querySnapshot = await messageCollection.get();
    totalCount = querySnapshot.size;

    querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
      message = LiveMessageModel.fromDocumentSnapshot(documentSnapshot);
      log("DOc snap : ${message!.message}");
      messagesList.add(message!);
    });
    notifyListeners();
    if (!sendChat) {
      isFetching = false;
      notifyListeners();
    }
  }

  Future<void> deleteCollection(String? streamerName) async {
    if (streamerName != null) {
      CollectionReference messageCollection =
          firestore.collection(streamerName);
      QuerySnapshot querySnapshot = await messageCollection.get();

      WriteBatch batch = firestore.batch();

      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        batch.delete(documentSnapshot.reference);
      });

      await batch.commit();
    } else {
      Fluttertoast.showToast(msg: 'Failed to fetch User Details');
    }
  }
}
