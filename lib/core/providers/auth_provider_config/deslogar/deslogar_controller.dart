import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/deslogar_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';

class DeslogarUsuario {
  Future<dynamic> _deslogar() => DeslogarImpl().deslogar();

  void encerrarSessao() async {
    await _deslogar().then((value) {
      VerificarSessao.limparDadosSessao();
      Modular.to.navigate(Modular.initialRoute);
    });
  }
}
