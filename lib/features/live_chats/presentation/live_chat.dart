import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/core/constants.dart';
import 'package:livestream/core/indicator.dart';
import 'package:livestream/features/home/model/stream_model.dart';
import 'package:livestream/features/live_chats/application/live_chat_controller.dart';
import 'package:provider/provider.dart';

import '../../live_view/presentation/live_view_appbar.dart';

class LiveChat extends StatelessWidget {
  const LiveChat({
    super.key,
    required this.streamer,
    required this.user,
  });

  final Live streamer;
  final UserData user;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final liveChatController =
          Provider.of<LiveChatController>(context, listen: false);
      await liveChatController.fetchMessages(streamer.user!.username!);
      log("total messages : ${liveChatController.totalCount}");
    });
    return Column(
      children: [
        Constants.height50,
        LiveViewAppBar(streamer: streamer),
        const Spacer(),
        Consumer<LiveChatController>(
          builder: (context, value, child) {
            // log('message: ${value.message}');
            if (value.isFetching) {
              return progressIndicator(Colors.black);
            } else {
              final time = FirebaseFirestore.instance
                  .collection(streamer.user!.username!)
                  .orderBy(streamer.user!.username!, descending: true)
                  .orderBy("time", descending: true);
              log('time : ${time.parameters}');
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(streamer.user!.username!)
                    .orderBy('time', descending: true)
                    .limit(5)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(28.0),
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: value.totalCount < 5 ? value.totalCount : 5,
                      itemBuilder: (context, index) {
                        log("message  list : ${value.messagesList[index].message}");
                        return Opacity(
                          opacity: 0.7,
                          child: Row(
                            children: [
                              const CircleAvatar(maxRadius: 20),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.messagesList[index].username,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    value.messagesList[index].message,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Constants.height20,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<LiveChatController>(
              builder: (context, value, child) => Container(
                height: 55,
                width: 324,
                decoration: BoxDecoration(
                  color: Palatte.textFieldColor.withOpacity(0.27),
                  border: Border.all(color: Palatte.strokeColor),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: value.textController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: 'Type Your Comment',
                        hintStyle: const TextStyle(color: Palatte.hintColor),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              onTap: () async {
                                await value.sendChat(
                                    user.username ?? '',
                                    value.textController.text,
                                    streamer.user!.username!,
                                    DateTime.now().millisecondsSinceEpoch);
                                await value.fetchMessages(
                                    streamer.user!.username!,
                                    sendChat: true);

                                value.textController.clear();
                              },
                              child: const Icon(Icons.send,
                                  color: Palatte.hintColor)),
                        )),
                    // onSubmitted: (val) async {
                    //   await value.sendChat(
                    //     user.username ?? '',
                    //     value.textController.text,
                    //     streamer.user!.username!,
                    //   );
                    //   await value.fetchMessages(streamer.user!.username!,
                    //       sendChat: true);
                    //   value.textController.clear();
                    // },
                  ),
                ),
              ),
            ),
            // _buildGiftWidget(context, streamer),
          ],
        ),
        Constants.height50,
      ],
    );
  }
}
