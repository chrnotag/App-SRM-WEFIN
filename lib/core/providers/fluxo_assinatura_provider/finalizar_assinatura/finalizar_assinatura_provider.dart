import 'dart:convert';
import 'dart:developer';
import 'package:crosspki/crosspki.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/assinatura_eletronica/assinatura_eletronica_provider.dart';
import 'package:modular_study/core/providers/fluxo_assinatura_provider/finalizar_assinatura/finalizar_assinatura_impl.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/core/utils/overlay.dart';
import 'package:modular_study/main.dart';
import 'package:modular_study/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import '../../certificado_provider/importar_certificado_provider.dart';
import '../iniciar_assinatura/iniciar_assinatura_provider.dart';

class FinalizarAssinaturaProvider extends ChangeNotifier {
  final IniciarAssinaturaProvider _assinaturaProvider =
      Modular.get<IniciarAssinaturaProvider>();

  ImportarCertificadoProvider certificadoProvider =
      Modular.get<ImportarCertificadoProvider>();
  AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
  IniciarAssinaturaProvider iniciarAssinatura =
      Modular.get<IniciarAssinaturaProvider>();

  List<FinalizarAssinaturaModel> _hashsAssinados = [];

  List<FinalizarAssinaturaModel> get hashsAssinados => _hashsAssinados;

  set hashsAssinados(List<FinalizarAssinaturaModel> hashs) {
    _hashsAssinados = hashs;
    notifyListeners();
  }

  Future<List<FinalizarAssinaturaModel>> _assinarHashs(PKCertificate cert) async {
    List<RespostaIniciarAssinaturaModel> hashs =
        _assinaturaProvider.hashsParaAssinar;
    List<FinalizarAssinaturaModel> hashAssinados = [];
    PKCertificate certificado = cert;
    for (var hash in hashs) {
      final hashAssinado = base64Encode((await CrossPki.signHash(certificado.thumbprint,
          DigestAlgorithm.sha256, base64Decode(hash.hashParaAssinar))).toList());
      log('hashAssinado: $hashAssinado}');
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
    PKCertificate certificado = certificadoProvider.certificadoSelecionado!;
    IniciarAssinaturaProvider iniciarAssinaturaProvider =
        Modular.get<IniciarAssinaturaProvider>();
    IniciarAssinaturaModel data = IniciarAssinaturaModel(
        certificadoBase64: certificadoProvider.converterCertificadoBase64(),
        codigoOperacao:
            assinaturaProvider.assinaturaSelecionada!.codigoOperacao);
    final hashs = await iniciarAssinaturaProvider.obterHashs(data);
    BuildContext context = myNavigatorKey.currentContext!;
    if (hashs.error == null) {
      final hashAssinados = await _assinarHashs(certificado);
      for (var documento in hashAssinados) {
        final result = await FinalizarAssinaturaImpl(assinaturaFinalizada: documento).finalizarAssinatura();
          OverlayApp.terminaOverlay();
          AssinaturaEletronicaProvider provider =
              Modular.get<AssinaturaEletronicaProvider>();
          showDialog(
            context: context,
            builder: (context) => provider.operacaoAssinada(),
          );
          break;
        }
      }
  }
}
