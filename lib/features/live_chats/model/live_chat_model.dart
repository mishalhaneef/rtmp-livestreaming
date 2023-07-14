import 'package:cloud_firestore/cloud_firestore.dart';

class LiveMessageModel {
  String username;
  String message;
  // int time;

  LiveMessageModel({
    required this.username,
    required this.message,
    // required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'message': message,
      // 'time': time, // Add the timestamp field
    };
  }

  factory LiveMessageModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return LiveMessageModel(
      username: data['username'] ?? '',
      message: data['message'] ?? '',
      // time: data['time'] ?? 0,
    );
  }
}
