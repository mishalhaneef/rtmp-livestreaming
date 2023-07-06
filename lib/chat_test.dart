// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:livestream/features/live_chats/application/live_chat_controller.dart';
// import 'package:provider/provider.dart';

// class ChatScreenTest extends StatefulWidget {
//   @override
//   _ChatScreenTestState createState() => _ChatScreenTestState();
// }

// class _ChatScreenTestState extends State<ChatScreenTest> {
//   final _controller = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firebase Chat'),
//       ),
//       body: Consumer<LiveChatController>(
//         builder: (context, value, child) => Column(
//           children: <Widget>[
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('message')
//                     .doc('collectionID')
//                     .collection('chat1')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   final messages = snapshot.data!.docs;
//                   return ListView.builder(
//                     reverse: true,
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message =
//                           messages[index].data() as Map<String, dynamic>;
//                       return ListTile(
//                         title: Text(message['text']),
//                         subtitle: Text(message['sender']),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message...',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () async {
//                       await value.createCollection();
//                       await value.fetchMessages();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
