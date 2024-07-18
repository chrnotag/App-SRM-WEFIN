import 'dart:io';

enum OS {
  ANDROID,
  IOS,
}

OS getCurrentPlatform() {
  if (Platform.isAndroid) {
    return OS.ANDROID;
  } else if (Platform.isIOS) {
    return OS.IOS;
  } else {
    throw UnsupportedError("Unsupported platform");
  }
}
