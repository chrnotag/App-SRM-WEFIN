import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  Future<String> getDeviceID() async {
    String device_id = '';
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        device_id = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        device_id = iosInfo.identifierForVendor!;
      }
    } catch (e) {
      //
    }

    return device_id;
  }
}
