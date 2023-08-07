import 'package:flutter_mobile_project/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter_mobile_project/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:flutter_mobile_project/app/core/local_storage/local_storage.dart';
import 'package:flutter_mobile_project/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:flutter_mobile_project/app/core/logger/app_logger.dart';
import 'package:flutter_mobile_project/app/core/logger/logger_app_logger_impl.dart';
import 'package:flutter_mobile_project/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:flutter_mobile_project/app/core/rest_client/rest_client.dart';
import 'package:flutter_mobile_project/app/modules/core/auth/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SqliteConnectionFactory(), export: true),
    Bind.lazySingleton<AppLogger>((i) => LoggerAppLoggerImpl(), export: true),
    Bind.lazySingleton<LocalStorage>((i) => SharedPreferencesLocalStorageImpl(),
        export: true),
    Bind.lazySingleton<LocalSecureStorage>(
        (i) => FlutterSecureStorageLocalStorageImpl(),
        export: true),
    Bind.lazySingleton(
        (i) => AuthStore(
              localStorage: i(),
            ),
        export: true),
    Bind.lazySingleton<RestClient>(
        (i) => DioRestClient(
              localStorage: i(),
              localSecureStorage: i(),
              log: i(),
              authStore: i(),
            ),
        export: true),
  ];
}
