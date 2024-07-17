import 'package:Srm_Asset/core/utils/overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/deslogar_impl.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';

class DeslogarUsuario {
  final BuildContext context;
  const DeslogarUsuario({required this.context});
  Future<dynamic> _deslogar() => DeslogarImpl().deslogar();

  void encerrarSessao() async {
    OverlayApp.iniciaOverlay(context);
    await _deslogar();
    VerificarSessao.limparDadosSessao();
    OverlayApp.terminaOverlay();
    Modular.to.navigate(Modular.initialRoute);
  }
}
