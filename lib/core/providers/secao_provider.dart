import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';

import '../../main.dart';

class SessionProvider with ChangeNotifier {
  bool _isShowingDialog = false;

  Timer? _timer;
  int _timeout = 60;

  SessionProvider() {
    startListening();
  }

  void startListening() {
    if (_timer?.isActive ?? false) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeout -= 1;
      log('TEMPO RESTANTE: $_timeout\\seg');
      if (_timeout == 0) {
        timer.cancel();
        mostrarAlerta();
      }
    });
    notifyListeners();
  }

  void stopListening() {
    if (!(_timer?.isActive ?? false)) {
      return;
    }
    _timer?.cancel();
    notifyListeners();
  }

  void resetListening() {
    if (_timer!.isActive) {
      _timer!.cancel();
    }
    _timeout = 60;
    startListening();
  }

  void mostrarAlerta() {
    if (myNavigatorKey.currentState != null && _isShowingDialog == false) {
      _isShowingDialog = true;
      stopListening();
      showDialog(
        barrierDismissible: false,
        context: myNavigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(
            'Atenção!',
            style:
                context.textTheme.bodyLarge!.copyWith(color: AppColors.error),
          ),
          content: Text(
            'Nenhuma ação foi realizada nos últimos 60 segundos. Você será direcionado para realizar o login novamente.',
            style: context.textTheme.bodyMedium,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      _isShowingDialog = false;
                      stopListening();
                      Modular.to.pushNamed(Modular.initialRoute);
                      Modular.to.pop();
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
