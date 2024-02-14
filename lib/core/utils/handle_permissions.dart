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
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      return statuses[Permission.storage]!.isGranted;
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status.isGranted;
  }
}
