import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/features/live_chats/model/live_chat_model.dart';

class LiveChatController extends ChangeNotifier {
  TextEditingController textController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? collectionID;
  LiveMessageModel? message;

  int totalCount = 0;

  Future<void> createCollection(String? streamerName) async {
    if (streamerName != null) {
      log('streamerName : $streamerName');

      try {
        CollectionReference messageCollection =
            firestore.collection(streamerName);
        // ? enable this code if any message needs to show as admin
        // ? after stream

        LiveMessageModel message =
            LiveMessageModel(username: 'vueflow', message: 'Welcome to Stream!');

        DocumentReference documentRef =
            await messageCollection.add(message.toMap());

        collectionID = documentRef.id;
        log('Collection ID: $collectionID');
      } catch (error) {
        log("Error on creating documents : $error");
      }
    } else {
      Fluttertoast.showToast(msg: 'Failed to fetch User Details');
    }
  }

  void sendChat(String username, String message) {
    _addChatMessage(username, message)
        .then((_) => print('Chat message added successfully'))
        .catchError((error) => print('Failed to add chat message: $error'));
  }

  Future<void> _addChatMessage(String username, String message) async {
    CollectionReference messageCollection = firestore.collection('message');
    DocumentReference documentRef =
        messageCollection.doc(); // Generate a new document ID

    Map<String, dynamic> chatData = {
      'username': username,
      'message': message,
    };

    await documentRef.set(chatData);
  }
 
  Future<List<LiveMessageModel>> fetchMessages(String streamerName) async {
    CollectionReference messageCollection = firestore.collection(streamerName);
    QuerySnapshot querySnapshot = await messageCollection.get();
    totalCount = querySnapshot.size;

    List<LiveMessageModel> messages = [];
    querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
      LiveMessageModel message =
          LiveMessageModel.fromDocumentSnapshot(documentSnapshot);
      messages.add(message);

      log('message : ${message.message}');
    });

    return messages;
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
