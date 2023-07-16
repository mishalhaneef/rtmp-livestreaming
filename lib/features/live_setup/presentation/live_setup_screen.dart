import 'dart:developer';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/features/live_chats/application/live_chat_controller.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
import 'package:livestream/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/user_base_controller.dart';
import '../../../core/constants.dart';

class LiveSetupScreen extends StatefulWidget {
  const LiveSetupScreen({Key? key}) : super(key: key);

  @override
  _LiveSetupScreenState createState() => _LiveSetupScreenState();
}

class _LiveSetupScreenState extends State<LiveSetupScreen>
    with WidgetsBindingObserver {
  final ButtonStyle buttonStyle =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  void initState() {
    super.initState();
    log('calls init');
    WidgetsBinding.instance.addObserver(this);
    final liveController = Provider.of<LiveController>(context, listen: false);

    WidgetsBinding.instance.addObserver(this);

    log('is not init');
    // liveController.createLiveStreamController();
    liveController.controller = ApiVideoLiveStreamController(
      initialAudioConfig: liveController.config.audio,
      initialVideoConfig: liveController.config.video,
      onConnectionSuccess: () {
        print('Connection succeeded');
      },
      onConnectionFailed: (error) {
        print('Connection failed: $error');
        Fluttertoast.showToast(msg: 'Connection Failed');
      },
      onDisconnection: () {
        Fluttertoast.showToast(msg: 'Disconnect');
      },
    );
    ;
    liveController.controller.initialize().catchError((e) {
      Fluttertoast.showToast(msg: '$e');
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final liveController = Provider.of<LiveController>(context, listen: false);

    if (state == AppLifecycleState.inactive) {
      log(liveController.controller.toString());
      log(state.toString());
      liveController.controller.stopPreview();
      liveController.controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      log(state.toString());
      liveController.controller.startPreview();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String? userID;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final pref = await SharedPreferences.getInstance();
      userID = pref.getString(PreferenceConstants.userID);
    });
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: Consumer<UserController>(
        builder: (context, value, child) => Consumer<LiveController>(
          builder: (context, liveController, child) => Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.48,
                child: ApiVideoCameraPreview(
                    controller: liveController.controller),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: GestureDetector(
                  onTap: NavigationHandler.pop(context),
                  child: const CircleAvatar(
                    maxRadius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: liveController.isStreaming
                          ? () async {
                              final liveChatController =
                                  Provider.of<LiveChatController>(context,
                                      listen: false);
                              final userController =
                                  Provider.of<UserController>(context,
                                      listen: false);

                              liveController.onStopStreamingButtonPressed();
                              await liveChatController.deleteCollection(
                                userController.userModel.user!.username,
                              );
                            }
                          : () async {
                              final liveChatController =
                                  Provider.of<LiveChatController>(context,
                                      listen: false);
                              final userController =
                                  Provider.of<UserController>(context,
                                      listen: false);
                              liveController
                                  .onStartStreamingButtonPressed(userID);
                              await liveChatController.createCollection(
                                  userController.userModel.user!.username);
                            },
                      child: CircleAvatar(
                        maxRadius: 38,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          maxRadius: 35,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            maxRadius: 33,
                            backgroundColor: Colors.white,
                            child: Icon(
                              liveController.isStreaming
                                  ? Icons.fiber_manual_record
                                  : Icons.fiber_manual_record,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: liveController.onSwitchCameraButtonPressed,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.cameraswitch_rounded,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
