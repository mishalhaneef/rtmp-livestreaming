import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:livestream/core/icons.dart';
import 'package:livestream/features/live_view/application/live_view_controller.dart';
import 'package:livestream/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../core/colors.dart';
import '../../../routes/app_routes.dart';
import '../../home/model/stream_model.dart';
import '../../live_chats/presentation/live_chat.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key, required this.streamer});

  final Live streamer;

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late VideoPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();

    log("URL : ${widget.streamer.url!.rtmp!}");

    _videoPlayerController =
        VideoPlayerController.network(widget.streamer.url!.rtmp!)
          ..initialize().then((_) {
            setState(() {});
          });
  }

//? HLS video player initialization
  //  late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   log("URL : ${widget.streamer.url!.hls!}");
  //   _controller =
  //       VideoPlayerController.networkUrl(Uri.parse(widget.streamer.url!.hls!))
  //         ..initialize().then((_) {
  //           // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //           setState(() {});
  //         });
  // }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //? VLC PLAYER WIDGET
          // Center(
          //   child: VlcPlayer(
          //     controller: _videoPlayerController,
          //     aspectRatio: 16 / 9,
          //     placeholder: const Center(child: CircularProgressIndicator()),
          //   ),
          // ),
          //? video PLAYER WIDGET
          _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : Container(),
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
          const Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.white,
              // color: Palatte.theme,
            ),
          ),
          LiveChat(streamer: widget.streamer),
        ],
      ),
    );
  }

  Widget _buildGiftWidget(BuildContext context, String streamerName) {
    final provider = Provider.of<LiveViewController>(context, listen: false);
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
                    provider.handleSubmitted(
                        provider.textController.text, true);
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
