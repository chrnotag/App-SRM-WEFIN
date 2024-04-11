import 'dart:convert';
import 'dart:developer';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/widgets/popup_generico.dart';
import 'package:crosspki/crosspki.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:Srm_Asset/core/providers/fluxo_assinatura_provider/finalizar_assinatura/finalizar_assinatura_impl.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/main.dart';
import 'package:Srm_Asset/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import 'package:Srm_Asset/widgets/popup_assinatura_feita.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import '../../certificado_provider/certificado_provider.dart';
import '../iniciar_assinatura/iniciar_assinatura_provider.dart';

class FinalizarAssinaturaProvider extends ChangeNotifier {
  final IniciarAssinaturaProvider _assinaturaProvider =
      Modular.get<IniciarAssinaturaProvider>();

  CertificadoProvider certificadoProvider =
      Modular.get<CertificadoProvider>();
  AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
  IniciarAssinaturaProvider iniciarAssinatura =
      Modular.get<IniciarAssinaturaProvider>();

  List<FinalizarAssinaturaModel> _hashsAssinados = [];

  List<FinalizarAssinaturaModel> get hashsAssinados => _hashsAssinados;

  set hashsAssinados(List<FinalizarAssinaturaModel> hashs) {
    _hashsAssinados = hashs;
    notifyListeners();
  }

  Future<List<FinalizarAssinaturaModel>> _assinarHashs(
      PKCertificate cert) async {
    List<RespostaIniciarAssinaturaModel> hashs =
        _assinaturaProvider.hashsParaAssinar;
    log("hashs para assinar: ${_assinaturaProvider.hashsParaAssinar}");
    List<FinalizarAssinaturaModel> hashAssinados = [];
    PKCertificate certificado = cert;
    for (var hash in hashs) {
      final hashAssinado = base64Encode((await CrossPki.signHash(
              certificado.thumbprint,
              DigestAlgorithm.sha256,
              base64Decode(hash.hashParaAssinar)))
          .toList());
      hashAssinados.add(FinalizarAssinaturaModel(
          codigoOperacao:
              assinaturaProvider.assinaturaSelecionada!.codigoOperacao,
          hashAssinado: hashAssinado.toString(),
          chaveDocumento: hash.chaveDocumento,
          token: hash.token));
      notifyListeners();
    }
    return hashAssinados;
  }

  finalizarAssinatura() async {
    PKCertificate certificado = certificadoProvider.certificadoAtual!;
    IniciarAssinaturaProvider iniciarAssinaturaProvider =
        Modular.get<IniciarAssinaturaProvider>();
    IniciarAssinaturaModel data = IniciarAssinaturaModel(
        certificadoBase64: certificadoProvider.converterCertificadoBase64(),
        codigoOperacao:
            assinaturaProvider.assinaturaSelecionada!.codigoOperacao);
    final hashs = await iniciarAssinaturaProvider.obterHashs(data);
    BuildContext context = myNavigatorKey.currentContext!;
    print('hashs do metodo finalizar: ${hashs.data}');
    if (hashs.error == null) {
      final hashAssinados = await _assinarHashs(certificado);
      ApiResponse<dynamic>? resultado;
      for (var documento in hashAssinados) {
        resultado =
            await FinalizarAssinaturaImpl(assinaturaFinalizada: documento)
                .finalizarAssinatura();
        if (resultado.error != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialogGenerico(
                title: 'Erro ao concluir assinatura}',
                msg:
                    'Houve um erro ao assinar o documento, tente novamente mais tarde',
                onPressed: () => Modular.to.pop()),
          );
          break;
        }
      }
      AssinaturaEletronicaProvider provider =
          Modular.get<AssinaturaEletronicaProvider>();
      if (resultado!.error == null) {
        showDialog(
          context: context,
          builder: (context) =>
              AssinaturaCompletaPopUp(codigoOperacao: provider.codigoOperacao),
        );
      }
    }
  }
}