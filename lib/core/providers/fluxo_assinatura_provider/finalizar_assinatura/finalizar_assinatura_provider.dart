import 'dart:typed_data';
import 'package:crosspki/crosspki.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:modular_study/models/fluxo_assinatura_model/finalizar_assinatura/finalizar_assinatura.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/iniciar_assinatura.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import '../../certificado_provider/importar_certificado_provider.dart';
import '../iniciar_assinatura/iniciar_assinatura_impl.dart';
import '../iniciar_assinatura/iniciar_assinatura_provider.dart';

class FinalizarAssinaturaProvider extends ChangeNotifier {
  final IniciarAssinaturaProvider _assinaturaProvider =
      Modular.get<IniciarAssinaturaProvider>();

  ImportarCertificadoProvider certificadoProvider =
  Modular.get<ImportarCertificadoProvider>();
  AssinaturaProvider assinaturaProvider = Modular.get<AssinaturaProvider>();
  IniciarAssinaturaProvider iniciarAssinatura = Modular.get<IniciarAssinaturaProvider>();

  final ImportarCertificadoProvider _certificadoProvider =
      Modular.get<ImportarCertificadoProvider>();

  List<FinalizarAssinaturaModel> _hashsAssinados = [];

  List<FinalizarAssinaturaModel> get hashsAssinados => _hashsAssinados;

  set hashsAssinados(List<FinalizarAssinaturaModel> hashs) {
    _hashsAssinados = hashs;
    notifyListeners();
  }

    Future<List<FinalizarAssinaturaModel>> _assinarHashs() async {
    List<RespostaIniciarAssinaturaModel> hashs =
        _assinaturaProvider.hashsParaAssinar;

    PKCertificate certificado = _certificadoProvider.certificadoSelecionado!;

    for (var hash in hashs) {
      final hashAssinado = (await CrossPki.signHash(certificado.thumbprint,
          DigestAlgorithm.sha256, hash.hashParaAssinar));

      hashsAssinados.add(FinalizarAssinaturaModel(codigoOperacao: assinaturaProvider.assinaturaSelecionada!.codigoOperacao, hashAssinado: hashAssinado.toString(), chaveDocumento: "chaveDocumento", token: hash.token));

      notifyListeners();
    }
    return hashsAssinados;
  }

  finalizarAssinatura() async {
    IniciarAssinaturaModel data = IniciarAssinaturaModel(
        certificado: certificadoProvider.converterCertificadoBase64(),
        codigoOperacao:
            assinaturaProvider.assinaturaSelecionada!.codigoOperacao);
    final hashs = await IniciarAssinaturaImpl(iniciarAssinaturaModel: data)
        .obterHashParaAssinar();
    if (hashs.error != null) {
      _assinarHashs();
    } else {
      return;
    }
  }
}
