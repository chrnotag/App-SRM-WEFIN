import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'auth_provider_config/logar/auth_providers.dart';
import '../../main.dart';

class SessionProvider with ChangeNotifier {
  bool _isShowingDialog = false;
  Timer? _timer;
  int _timeout = 120;
  final AuthProvider authProvider = Modular.get<AuthProvider>();

  SessionProvider() {
    startListening();
  }

  void startListening() {

    if (_timer?.isActive ?? false) {
      return;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeout -= 1;
      if (_timeout == 0) {
        mostrarAlerta();
        timer.cancel();
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
    _timeout = 120;
    startListening();
  }

  void mostrarAlerta() {
    if (myNavigatorKey.currentState != null && _isShowingDialog == false) {
      _isShowingDialog = true;
      stopListening();
      showDialog(
          barrierDismissible: false,
          context: myNavigatorKey.currentContext!,
          builder: (context) => AlertDialogGenerico(
              title: 'Atenção!',
              msg:
                  'Nenhuma ação foi realizada nos últimos 60 segundos. Você será direcionado para realizar o login novamente.',
              onPressed: () {
                _isShowingDialog = false;
                VerificarSessao.limparDadosSessao();
                Modular.to.navigate(Modular.initialRoute);
              }));
    }
  }
}
