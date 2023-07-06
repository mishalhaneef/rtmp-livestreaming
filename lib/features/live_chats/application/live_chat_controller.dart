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

  Future<void> createCollection(String streamerName) async {
    CollectionReference messageCollection = firestore.collection(streamerName);
    message = LiveMessageModel(username: 'John', message: 'Hello, world!');
    DocumentReference documentRef =
        await messageCollection.add(message!.toMap());

    String collectionID = documentRef.id;
    print('Collection ID: $collectionID');
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
}
