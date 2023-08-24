import 'package:flutter_mobile_project/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/cupertino.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var connection = SqliteConnectionFactory();

    if (state == AppLifecycleState.resumed) {
      connection.openConnection();
    } else {
      connection.closeConnection();
    }
    super.didChangeAppLifecycleState(state);
  }
}
