import 'dart:developer';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/core/colors.dart';
import 'package:livestream/features/live_chats/application/live_chat_controller.dart';
import 'package:livestream/features/live_setup/application/live_setup_controller.dart';
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

    // _controller = createLiveStreamController();

    // _controller.initialize().catchError((e) {
    //   showInSnackBar(e.toString());
    // });
    WidgetsBinding.instance.addObserver(this);

    //log("message : ${liveController.controller}");

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
// @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.inactive) {
//       _controller.stop();
//     } else if (state == AppLifecycleState.resumed) {
//       _controller.startPreview();
//     }
//   }

  // @override
  // void dispose() async {
  //   final liveController = Provider.of<LiveController>(context, listen: false);
  //   await liveController.disposeLiveStreamController();
  //   WidgetsBinding.instance.removeObserver(this);

  //   super.dispose();
  // }

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
    // final userController = Provider.of<UserController>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await UserPreferenceManager.getUserDetails(userController);
    // });
    return Consumer<UserController>(
      builder: (context, value, child) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value.userModel.user!.username ?? 'Live Stream',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: 15,
              )
            ],
          ),
          actions: <Widget>[
            Consumer<LiveController>(
              builder: (context, liveController, child) {
                return PopupMenuButton<String>(
                  color: Colors.black,
                  onSelected: (choice) =>
                      liveController.onMenuSelected(choice, context),
                  itemBuilder: (BuildContext context) {
                    return SettingConstants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                );
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 10),
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Consumer<LiveController>(
                          builder: (context, liveController, child) => Stack(
                            children: [
                              ApiVideoCameraPreview(
                                  controller: liveController.controller),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: liveController.isStreaming
                                          ? Colors.red
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    child: Text(
                                      'Live',
                                      style: TextStyle(
                                        color: liveController.isStreaming
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255,
                                                111,
                                                111,
                                                111,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              _controlRowWidget()
            ],
          ),
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _controlRowWidget() {
    String? userID;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final pref = await SharedPreferences.getInstance();
      userID = pref.getString(PreferenceConstants.userID);
    });
    log('userid on live : $userID');
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 232, 232, 232), blurRadius: 10),
            BoxShadow(
                color: Color.fromARGB(255, 232, 232, 232), blurRadius: 10),
          ],
        ),
        child: Consumer<LiveController>(
          builder: (context, value, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.cameraswitch),
                color: Palatte.themeGreenColor,
                onPressed: value.onSwitchCameraButtonPressed,
              ),
              IconButton(
                icon: const Icon(Icons.mic_off),
                color: Palatte.themeGreenColor,
                onPressed: value.onToggleMicrophoneButtonPressed,
              ),
              IconButton(
                icon: const Icon(Icons.fiber_manual_record),
                color: value.isStreaming ? Colors.grey : Colors.red,
                onPressed: value.isStreaming
                    ? null
                    : () async {
                        final liveChatController =
                            Provider.of<LiveChatController>(context,
                                listen: false);
                        final userController =
                            Provider.of<UserController>(context, listen: false);
                        await liveChatController.createCollection(
                            userController.userModel.user!.username);
                        value.onStartStreamingButtonPressed(userID);
                      },
              ),
              IconButton(
                  icon: const Icon(Icons.stop),
                  color: value.isStreaming ? Colors.red : Colors.grey,
                  onPressed: value.isStreaming
                      ? () async {
                          final liveChatController =
                              Provider.of<LiveChatController>(context,
                                  listen: false);
                          final userController = Provider.of<UserController>(
                              context,
                              listen: false);

                          await liveChatController.deleteCollection(
                            userController.userModel.user!.username,
                          );
                          value.onStopStreamingButtonPressed();
                        }
                      : null)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(
      BuildContext context, String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(description),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
