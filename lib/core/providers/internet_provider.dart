import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectionStatusController.close();
    super.dispose();
  }
}
