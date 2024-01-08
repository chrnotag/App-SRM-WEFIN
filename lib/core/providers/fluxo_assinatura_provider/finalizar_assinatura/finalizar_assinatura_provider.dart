import 'dart:typed_data';
import 'package:crosspki/crosspki.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';
import '../../certificado_provider/importar_certificado_provider.dart';
import '../iniciar_assinatura/iniciar_assinatura_provider.dart';

class FinalizarAssinaturaProvider extends ChangeNotifier {
  final IniciarAssinaturaProvider _assinaturaProvider =
      Modular.get<IniciarAssinaturaProvider>();

  final ImportarCertificadoProvider _certificadoProvider =
      Modular.get<ImportarCertificadoProvider>();

  List<Uint8List> _hashsAssinados = [];

  List<Uint8List> get hashsAssinados => _hashsAssinados;

  set hashsAssinados(List<Uint8List> hashs) {
    _hashsAssinados = hashs;
    notifyListeners();
  }

  Future<void> assinarHashs() async {
    List<RespostaIniciarAssinaturaModel> hashs =
        _assinaturaProvider.hashsParaAssinar;

    PKCertificate certificado = _certificadoProvider.certificadoSelecionado!;

    for (var hash in hashs) {
      hashsAssinados.add(await CrossPki.signHash(certificado.thumbprint,
          DigestAlgorithm.sha256, hash.hashParaAssinar));
      notifyListeners();
    }
  }
}
