import 'dart:developer';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livestream/configs/api_end_points.dart';
import 'package:livestream/features/live_setup/presentation/setting.dart';

class LiveController extends ChangeNotifier {
  bool isSwitch = false;
  bool goingLive = false;
  Params config = Params();
  late ApiVideoLiveStreamController controller;
  bool isStreaming = false;

  onButtonEnables(val) {
    isSwitch = val;
    if (val) {
      Fluttertoast.showToast(msg: 'Comment Enabled');
    } else {
      Fluttertoast.showToast(msg: 'Comment Disabled');
    }
    notifyListeners();
  }

  onGoLive() async {
    goingLive = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    Fluttertoast.showToast(msg: 'Live Server Not Found');
    goingLive = false;
    notifyListeners();
  }

  setStream(bool value) {
    isStreaming = value;
    notifyListeners();
  }

  createLiveStreamController() {
    controller = ApiVideoLiveStreamController(
      initialAudioConfig: config.audio,
      initialVideoConfig: config.video,
      onConnectionSuccess: () {
        print('Connection succeeded');
      },
      onConnectionFailed: (error) {
        print('Connection failed: $error');
        Fluttertoast.showToast(msg: 'Connection Failed');
      },
      onDisconnection: () {
        Fluttertoast.showToast(msg: 'Disconnect');

        isStreaming = false;
        notifyListeners();
      },
    );
  }

  Future<void> disposeLiveStreamController() async {
    // await controller?.dispose();
    log('not disposing');
  }

  void onMenuSelected(String choice, BuildContext context) {
    if (choice == SettingConstants.Settings) {
      awaitResultFromSettingsFinal(context);
    }
  }

  void awaitResultFromSettingsFinal(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsScreen(params: config)));
    controller.setVideoConfig(config.video);
    controller.setAudioConfig(config.audio);
  }

  Future<void> switchCamera() async {
    final ApiVideoLiveStreamController? liveStreamController = controller;

    if (liveStreamController == null) {
      Fluttertoast.showToast(msg: ' create a camera controller first.');
      return;
    }

    return liveStreamController.switchCamera();
  }

  Future<void> toggleMicrophone() async {
    final ApiVideoLiveStreamController? liveStreamController = controller;

    if (liveStreamController == null) {
      Fluttertoast.showToast(msg: 'Error: create a camera controller first.');
      return;
    }

    return await liveStreamController.toggleMute();
  }

  Future<void> startStreaming(String? userID) async {
    final ApiVideoLiveStreamController? _controller = controller;
    if (userID == null) {
      print('Error: UID is Empty d ');
      return;
    }

    String rtmpUrl = "${ApiEndPoints.rtmpBaseUrl}/live";
    String streamKey = userID;

    if (_controller == null) {
      print('Error: create a camera controller first.');
      return;
    }

    return await _controller.startStreaming(streamKey: streamKey, url: rtmpUrl);
  }

  Future<void> stopStreaming() async {
    final ApiVideoLiveStreamController controller = this.controller;
    log(controller.toString());
    // ignore: unnecessary_null_comparison
    if (controller == null) {
      print('Error: create a camera controller first.');
      return;
    }

    return await controller.stopStreaming();
  }

  void onSwitchCameraButtonPressed() {
    switchCamera().then((_) {
      notifyListeners();
    }).catchError((error) {
      if (error is PlatformException) {
        Fluttertoast.showToast(
            msg: "Failed to switch camera: ${error.message}");
      } else {
        Fluttertoast.showToast(msg: "Failed to switch camera: $error");
      }
    });
  }

  void onToggleMicrophoneButtonPressed() {
    toggleMicrophone().then((_) {
      notifyListeners();
    }).catchError((error) {
      if (error is PlatformException) {
        Fluttertoast.showToast(
            msg: "Failed to switch camera: ${error.message}");
      } else {
        Fluttertoast.showToast(msg: "Failed to switch camera: $error");
      }
    });
  }

  void onStartStreamingButtonPressed(String? userID) {
    startStreaming(userID).then((_) {
      isStreaming = true;
      notifyListeners();
    }).catchError((error) {
      if (error is PlatformException) {
        Fluttertoast.showToast(
            msg: "Failed to switch camera: ${error.message}");
      } else {
        Fluttertoast.showToast(msg: "Failed to switch camera: $error");
      }
    });
  }

  void onStopStreamingButtonPressed() {
    isStreaming = false;
    notifyListeners();
    stopStreaming().then((_) {}).catchError((error) {
      log('error $error');
      if (error is PlatformException) {
        Fluttertoast.showToast(
            msg: "Failed to switch camera: ${error.message}");
      } else {
        Fluttertoast.showToast(msg: "Failed to switch camera: $error");
      }
    });
  }
}

Map<Resolution, String> getResolutionsMap() {
  Map<Resolution, String> map = {};
  for (final res in Resolution.values) {
    map[res] = res.toPrettyString();
  }
  return map;
}

class SettingConstants {
  static const String Settings = "Settings";

  static const List<String> choices = <String>[
    Settings,
  ];
}

List<int> fpsList = [24, 25, 30];
List<int> audioBitrateList = [32000, 64000, 128000, 192000];

String defaultValueTransformation(int e) {
  return "$e";
}

extension ListExtension on List<int> {
  Map<int, String> toMap(
      {Function(int e) valueTransformation = defaultValueTransformation}) {
    var map = Map<int, String>.fromIterable(this,
        key: (e) => e, value: (e) => valueTransformation(e));
    return map;
  }
}

String bitrateToPrettyString(int bitrate) {
  return "${bitrate / 1000} Kbps";
}

class Params {
  final VideoConfig video = VideoConfig.withDefaultBitrate();
  final AudioConfig audio = AudioConfig();

  String getResolutionToString() {
    return video.resolution.toPrettyString();
  }

  String getChannelToString() {
    return audio.channel.toPrettyString();
  }

  String getBitrateToString() {
    return bitrateToPrettyString(audio.bitrate);
  }

  String getSampleRateToString() {
    return audio.sampleRate.toPrettyString();
  }
}

extension ResolutionExtension on Resolution {
  String toPrettyString() {
    var result = "";
    switch (this) {
      case Resolution.RESOLUTION_240:
        result = "352x240";
        break;
      case Resolution.RESOLUTION_360:
        result = "640x360";
        break;
      case Resolution.RESOLUTION_480:
        result = "858x480";
        break;
      case Resolution.RESOLUTION_720:
        result = "1280x720";
        break;
      case Resolution.RESOLUTION_1080:
        result = "1920x1080";
        break;
      default:
        result = "1280x720";
        break;
    }
    return result;
  }
}

Map<SampleRate, String> getSampleRatesMap() {
  Map<SampleRate, String> map = {};
  for (final res in SampleRate.values) {
    map[res] = res.toPrettyString();
  }
  return map;
}

extension SampleRateExtension on SampleRate {
  String toPrettyString() {
    var result = "";
    switch (this) {
      case SampleRate.kHz_11:
        result = "11 kHz";
        break;
      case SampleRate.kHz_22:
        result = "22 kHz";
        break;
      case SampleRate.kHz_44_1:
        result = "44.1 kHz";
        break;
    }
    return result;
  }
}

Map<Channel, String> getChannelsMap() {
  Map<Channel, String> map = {};
  for (final res in Channel.values) {
    map[res] = res.toPrettyString();
  }
  return map;
}

extension ChannelExtension on Channel {
  String toPrettyString() {
    var result = "";
    switch (this) {
      case Channel.mono:
        result = "mono";
        break;
      case Channel.stereo:
        result = "stereo";
        break;
      default:
        result = "stereo";
        break;
    }
    return result;
  }
}
