import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/iniciar_assinatura/iniciar_assinatura_impl.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../../../main.dart';
import '../../../../views/home/assinaturas/selecionar_certificado.dart';
import '../../../constants/route_labels.dart';
import '../../certificado_provider/certificado_provider.dart';

class IniciarAssinaturaProvider extends ChangeNotifier {
  List<RespostaIniciarAssinaturaModel> _hashsParaAssinar = [];

  List<RespostaIniciarAssinaturaModel> get hashsParaAssinar =>
      _hashsParaAssinar;

  set hashsParaAssinar(List<RespostaIniciarAssinaturaModel> hashs) {
    _hashsParaAssinar = hashs;
    notifyListeners();
  }

  Future<dynamic> obterHashs(IniciarAssinaturaModel model) =>
      IniciarAssinaturaImpl(iniciarAssinaturaModel: model)
          .obterHashParaAssinar();

  void IniciarAssinatura(
      InformacaoAssinante assinante, BuildContext context) async {
    if (!assinante.eCPFAssinador) {
      AssinaturaEletronicaProvider assinaturaEletronicaProvider =
          Modular.get<AssinaturaEletronicaProvider>();
      showDialog(
          context: myNavigatorKey.currentState!.context,
          builder: (context) => assinaturaEletronicaProvider
              .confirmarAssinaturaDialog(assinante, context));
    } else {
      CertificadoProvider certificadoProvider =
          context.watch<CertificadoProvider>();
      await certificadoProvider.listaCertificadosFuture();
      if (certificadoProvider.listaCertificados.isEmpty) {
        Modular.to.pushNamed(AppRoutes.importarCertificadoRoute);
      } else {
        showDialog(
          context: myNavigatorKey.currentContext!,
          builder: (context) => SelecionarCertificado(),
        );
      }
    }
  }

  void limparHashs() {
    _hashsParaAssinar = [];
  }
}
