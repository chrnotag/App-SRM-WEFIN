import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/certificado_provider/importar_certificado_provider.dart';
import 'package:modular_study/main.dart';
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';

import '../../../../views/home/assinaturas/selecionar_certificado.dart';
import '../../../constants/route_labels.dart';

class IniciarAssinaturaProvider extends ChangeNotifier {
  List<RespostaIniciarAssinaturaModel> _hashsParaAssinar = [];
  List<RespostaIniciarAssinaturaModel> get hashsParaAssinar => _hashsParaAssinar;

  set hashsParaAssinar(List<RespostaIniciarAssinaturaModel> hashs) {
    _hashsParaAssinar = hashs;
    notifyListeners();
  }

  void IniciarAssinaturaCertificado() async {
    ImportarCertificadoProvider certificadoProvider = Modular.get<ImportarCertificadoProvider>();
    await certificadoProvider.listaCertificadosFuture();
    if (certificadoProvider.listaCertificados.isEmpty) {
      Modular.to.pushNamed(AppRoutes.importarCertificadoRoute);
    } else {
      showDialog(
        context: myNavigatorKey.currentContext!,
        builder: (context) => SelecionarCertificado(),
        useSafeArea: true,
      );
    }
  }

  void limparHashs(){
    hashsParaAssinar = [];
    notifyListeners();
  }
}
