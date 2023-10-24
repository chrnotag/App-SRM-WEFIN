import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_implementation.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  pegarAssinaturas(String identificador) =>
      AssinaturaImpl(identificador: identificador).assinaturas();

  set assinaturas(List<AssinaturasModel> assinaturasModel) {
    separaAssinaturas(assinaturasModel);
    notifyListeners();
  }

  List<AssinaturasModel> _assinaturasPendentes = [];
  List<AssinaturasModel> _acompanharAssinaturas = [];

  List<AssinaturasModel> get acompanharAssinaturas => _assinaturasPendentes;

  set acompanharAssinaturas(List<AssinaturasModel> docs) {
    _assinaturasPendentes = docs;
  }

  List<AssinaturasModel> get assinaturasPendentes => _acompanharAssinaturas;

  set assinaturasPendentes(List<AssinaturasModel> docs) {
    _acompanharAssinaturas = docs;
  }

  String notificacaoPendentes() {
    return assinaturasPendentes.length.toString();
  }

  void separaAssinaturas(List<AssinaturasModel> assinaturas) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    for (var assinatura in assinaturas) {
      bool assinadoPeloUsuario = assinatura.assinantes.any((assinante) =>
          assinante.informacoesAssinante.any((info) =>
              info.identificadorAssinador ==
                  authProvider.dataUser!.identificadorUsuario &&
              info.statusAssinatura != "Assinado"));
      if (assinadoPeloUsuario) {
        _acompanharAssinaturas.add(assinatura);
      } else {
        _assinaturasPendentes.add(assinatura);
      }
    }
    notifyListeners();
  }

  void limparAssinaturas() {
    assinaturasPendentes = [];
    acompanharAssinaturas = [];
    notifyListeners();
  }
}
