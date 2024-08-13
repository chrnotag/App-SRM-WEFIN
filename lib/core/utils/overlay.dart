import 'package:Srm_Asset/core/constants/extensions/screen_util_extension.dart';
import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/sessao_provider.dart';
import 'lista_execao_tempo_sessao.dart';

class _LoaderOverlay extends StatelessWidget {
  const _LoaderOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: CircularProgressIndicator(color: context.primaryColor, strokeWidth: 2.w,),
      ),
    );
  }
}


class OverlayApp {
  static final _overlayLoader = OverlayEntry(
    builder: (context) => const Material(
      color: Colors.transparent,
      child: _LoaderOverlay(),
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
