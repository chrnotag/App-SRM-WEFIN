import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/sessao_provider.dart';

import '../../widgets/loader_widget.dart';

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
    sessaoProvider.startListening();
    _overlayLoader.remove();
  }
}
