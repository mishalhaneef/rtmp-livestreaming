import 'package:cloud_firestore/cloud_firestore.dart';

class LiveMessageModel {
  String username;
  String message;

  LiveMessageModel({required this.username, required this.message});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'message': message,
    };
  }

  factory LiveMessageModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return LiveMessageModel(
      username: data['username'] ?? '',
      message: data['message'] ?? '',
    );
  }
}
