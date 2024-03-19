import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';

import '../../widgets/loader_widget.dart';
import 'lista_execao_tempo_sessao.dart';

class OverlayApp {
  static final _overlayLoader = OverlayEntry(
    builder: (context) => const Material(
      color: Colors.transparent,
      child: Loader(),
    ),
  );

  static iniciaOverlay(BuildContext context) {
    final SessionProvider sessaoProvider = Modular.get<SessionProvider>();
    sessaoProvider.stopListening();
    Overlay.of(context).insert(_overlayLoader);
  }

  static terminaOverlay() {
    final SessionProvider sessaoProvider = Modular.get<SessionProvider>();
    if (!ListaExecaoTimeOut.routes.contains(Modular.to.path)) {
      sessaoProvider.startListening();
    }
    _overlayLoader.remove();
  }
}
