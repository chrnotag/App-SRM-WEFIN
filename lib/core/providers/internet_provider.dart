import 'dart:async';
import 'package:Srm_Asset/core/constants/route_labels.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'package:Srm_Asset/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityProvider with ChangeNotifier {
  final _connectionStatusController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;
  bool _isOnline = false;

  bool get isOnline => _isOnline;

  set isOnline(bool value) {
    if (_isOnline != value) {
      _isOnline = value;
      notifyListeners();
    }
  }

  ConnectivityProvider() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      isOnline = (status == InternetConnectionStatus.connected);
      _connectionStatusController.add(isOnline);
      if (!isOnline) {
        _showNoConnectionScreen();
      } else {
        Modular.to.navigate(Modular.initialRoute);
      }
    });
  }

  void _showNoConnectionScreen() {
    final SessionProvider sessionProvider = Modular.get<SessionProvider>();
    final context = myNavigatorKey.currentContext;
    if (context != null) {
      sessionProvider.stopListening();
      Modular.to.navigate(AppRoutes.semConexaoRoute);
    }
  }

  @override
  void dispose() {
    _connectionStatusController.close();
    super.dispose();
  }
}
