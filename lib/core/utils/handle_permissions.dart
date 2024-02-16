import 'package:media_storage/media_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class HandlePermissions {
  static Future<bool> permissaoLocalizacao() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      return statuses[Permission.location]!.isGranted;
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status.isGranted;
  }

  static Future<bool> permissionStorage() async {
    bool isPermission = await MediaStorage.getRequestStoragePermission();
    return isPermission;
  }
}