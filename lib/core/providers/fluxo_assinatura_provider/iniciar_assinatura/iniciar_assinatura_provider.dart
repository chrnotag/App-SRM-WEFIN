import 'package:Srm_Asset/views/home/importar_certificado/importar_certificado.dart';
import 'package:Srm_Asset/widgets/card_monitor_assinaturas/confirmar_assinatura_dialog.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:crosspki/crosspki.dart';
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

  InformacaoAssinante? obterInformacoesUsuarioLogado(
      MonitorAssinaturasModel assinatura, String usuarioLogadoId) {
    try {
      // Buscar o assinante que possui a informação do usuário logado
      var informacaoUsuarioLogado = assinatura.assinantes
          .expand((assinante) => assinante.informacoesAssinante)
          .firstWhere((info) => info.identificadorAssinador == usuarioLogadoId);

      return informacaoUsuarioLogado;
    } catch (e) {
      // Tratamento de exceção caso não encontre nenhum assinante
      print('Informação do assinante não encontrada, $e');
      return null;
    }
  }

  void IniciarAssinatura(
      InformacaoAssinante? assinante, BuildContext context) async {
    if (assinante == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogGenerico(
                title: 'Assinante não encontrado',
                msg: 'Assinante não foi encontrado no sistema',
                onPressed: () => Modular.to.pop(),
              ));
    } else {
      if (!assinante.eCPFAssinador) {
        AssinaturaEletronicaProvider assinaturaEletronicaProvider =
            Modular.get<AssinaturaEletronicaProvider>();
        showDialog(
            context: myNavigatorKey.currentState!.context,
            builder: (context) => ConfirmarAssinaturaDialog(assinante: assinante));
      } else {
        CertificadoProvider certificadoProvider =
            context.watch<CertificadoProvider>();
        List<PKCertificate> certificados = await certificadoProvider.listaCertificadosFuture();
        if (certificados.isEmpty) {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
                onClosing: () {},
                builder: (context) => ImportarCertificado(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)))),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => SelecionarCertificado(),
          );
        }
      }
    }
  }

  void limparHashs() {
    _hashsParaAssinar = [];
  }
}
