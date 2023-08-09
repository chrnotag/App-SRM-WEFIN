import 'package:flutter_mobile_project/app/core/helpers/environments.dart';
import 'package:flutter/cupertino.dart';

class ApplicationConfig {
  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _loadEnvs();
  }

  Future<void> _loadEnvs() => Environments.loadEnvs();
}
