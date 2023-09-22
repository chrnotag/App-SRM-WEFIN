import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import '../../main.dart';

class SessionProvider with ChangeNotifier {
  final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 30),
      invalidateSessionForUserInactivity: const Duration(seconds: 30));

  final sessionStateStream = StreamController<SessionState>();

  bool _isShowingDialog = false;

  SessionProvider() {
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        showMyAlertDialog();
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle app lost focus timeout
        Modular.to.pushNamed(Modular.initialRoute);
      }
    });
  }

  void startListening() {
    sessionStateStream.add(SessionState.startListening);
  }

  void stopListening() {
    sessionStateStream.add(SessionState.stopListening);
  }

  void showMyAlertDialog() {
    if (myNavigatorKey.currentState != null && _isShowingDialog == false) {
      _isShowingDialog = true;
      showDialog(
        barrierDismissible: false,
        context: myNavigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text('Sessão expirada!'),
          content: Text('Usuario desconectado por inatividade'),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      _isShowingDialog = false;
                      Modular.to.pushNamed(Modular.initialRoute);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
