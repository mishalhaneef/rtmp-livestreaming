import 'dart:developer';

// import 'package:better_player/better_player.dart';
// import 'package:fijkplayer/fijkplayer.dart';

import 'package:chewie/chewie.dart';
import 'package:fl_video/fl_video.dart';
import 'package:flutter/material.dart';
import 'package:livestream/core/base_user_model.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:livestream/core/icons.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';
import '../../../routes/app_routes.dart';
import '../../home/model/stream_model.dart';
import '../../live_chats/application/live_chat_controller.dart';
import '../../live_chats/presentation/live_chat.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key, required this.streamer, required this.user});

  final Live streamer;
  final UserData user;

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void initializePlayer() {
    _videoPlayerController =
        VideoPlayerController.network(widget.streamer.url!.hls!);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //? video PLAYER WIDGET
          Chewie(
            controller: _chewieController,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
          ),
          // const Center(
          //   child: CircularProgressIndicator.adaptive(
          //     backgroundColor: Colors.white,
          //     // color: Palatte.theme,
          //   ),
          // ),
          LiveChat(streamer: widget.streamer, user: widget.user),
        ],
      ),
    );
  }

  Widget _buildGiftWidget(BuildContext context, String streamerName) {
    final provider = Provider.of<LiveChatController>(context, listen: false);
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(40, 50, 40, 20),
            actionsPadding: const EdgeInsets.fromLTRB(40, 20, 40, 50),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('Gift to $streamerName'),
            // buttonPadding: buttonPadding,
            // contentPadding: contentPadding,
            content: Container(
              height: 53,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(-4, -4),
                    blurRadius: 50,
                    spreadRadius: -20,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                child: TextField(
                  controller: provider.textController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter Gift Amount',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.money),
                  ),
                ),
              ),
            ),

            elevation: 0.2,
            actions: [
              AppButton(
                hint: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Palatte.themeGreenColor,
                onTap: () {
                  if (provider.textController.text.isNotEmpty) {
                    // provider.sendChat(username, message);
                    //? send donation part
                    NavigationHandler.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
      child: Container(
        height: 53,
        decoration: BoxDecoration(
            border: Border.all(color: Palatte.strokeColor),
            borderRadius: BorderRadius.circular(100)),
        child: CircleAvatar(
          backgroundColor: Palatte.textFieldColor.withOpacity(0.27),
          radius: 27,
          child: Image.asset(
            AppIcon.gift,
            height: 25,
          ),
        ),
      ),
    );
  }
}
