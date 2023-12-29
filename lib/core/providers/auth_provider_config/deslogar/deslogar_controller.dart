import 'package:fluttertoast/fluttertoast.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/deslogar_impl.dart';
import 'package:modular_study/core/providers/auth_provider_config/deslogar/verificar_sessao.dart';
class DeslogarUsuario{
  Future<dynamic> deslogar() => DeslogarImpl().deslogar();

  void verificarSessao() async {
    final response = await deslogar();
    if (response.error != null) {
      VerificarSessao.limparDadosSessao();
    } else {
      Fluttertoast.showToast(msg: 'Erro ao deslogar Usuário, tente novamente');
    }
  }
}
