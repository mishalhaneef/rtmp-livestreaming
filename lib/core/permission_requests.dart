import 'package:permission_handler/permission_handler.dart';

Future<bool> requestMicrophoneAndCameraPermissions() async {
  PermissionStatus cameraStatus = await Permission.camera.request();

  PermissionStatus microphoneStatus = await Permission.microphone.request();

  if (cameraStatus.isGranted && microphoneStatus.isGranted) {
    return true;
  } else if (cameraStatus.isDenied || microphoneStatus.isDenied) {
    return false;
  } else {
    bool shouldRequestCamera =
        cameraStatus.isRestricted || cameraStatus.isPermanentlyDenied;
    bool shouldRequestMicrophone =
        microphoneStatus.isRestricted || microphoneStatus.isPermanentlyDenied;

    if (shouldRequestCamera || shouldRequestMicrophone) {
      Map<Permission, PermissionStatus> statuses = await [
        if (shouldRequestCamera) Permission.camera,
        if (shouldRequestMicrophone) Permission.microphone,
      ].request();

      if (statuses.containsKey(Permission.camera) &&
          statuses[Permission.camera]!.isGranted &&
          statuses.containsKey(Permission.microphone) &&
          statuses[Permission.microphone]!.isGranted) {
        return true;
      }
    }

    return false;
  }
}
