import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/deslogar_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';

class DeslogarUsuario {
  Future<dynamic> deslogar() => DeslogarImpl().deslogar().then((value) => _verificarSessao());

  void _verificarSessao() async {
    await deslogar().then((value) {
      VerificarSessao.limparDadosSessao();
      Modular.to.navigate(Modular.initialRoute);
    });
  }
}
