import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/features/chats/application/chat_controller.dart';
import 'package:livestream/features/chats/presentation/widgets/message_thread.dart';
import 'package:livestream/widgets/textfield.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key, this.userData});

  final UserData? userData;

  @override
  Widget build(BuildContext context) {
    // final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: _buildChatRoomHeader(context, userData!),
      ),
      body: Column(
        children: [
          Constants.height20,
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, value, child) => Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        if (value.messages.isNotEmpty)
                          const Center(child: Text('Today')),
                        Constants.height30,
                        _buildMessageThread(value),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Consumer<ChatProvider>(
                      builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: AppTextField(
                          controller: value.textController,
                          hint: 'Your message',
                          height: 55,
                          chat: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView _buildMessageThread(ChatProvider value) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      reverse: true,
      itemCount: value.messages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = value.messages[index];
        return MessageThread(
          message: message.message,
          time: message.time,
          isMe: index % 2 != 0,
          readed: true,
          limitReached: index == 0 ? true : false,
        );
      },
    );
  }

  Row _buildChatRoomHeader(BuildContext context, UserData user) {
    return Row(
      children: [
        CircleAvatar(maxRadius: 25, backgroundImage: NetworkImage(user.image!)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name ?? '',
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 3),
            Text(
              user.username ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            )
          ],
        ),
      ],
    );
  }
}
