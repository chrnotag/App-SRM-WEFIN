import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_implementation.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  pegarAssinaturas() => AssinaturaImpl().assinaturas();

  set assinaturas(List<AssinaturasModel> assinaturasModel) {
    separaAssinaturas(assinaturasModel);
    todasAssinaturas = assinaturasModel;
    notifyListeners();
  }

  List<AssinaturasModel> _assinaturas = [];

  List<AssinaturasModel> get todasAssinaturas => _assinaturas;

  set todasAssinaturas(List<AssinaturasModel> assinaturas) =>
      _assinaturas = assinaturas;

  List<AssinaturasModel> _assinaturasPendentes = [];

  List<AssinaturasModel> get assinaturasPendentes => _assinaturasPendentes;

  set assinaturasPendentes(List<AssinaturasModel> docs) {
    _assinaturasPendentes = docs;
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
        _assinaturasPendentes.add(assinatura);
      }
    }
    notifyListeners();
  }

  void limparAssinaturas() {
    todasAssinaturas = [];
    assinaturasPendentes = [];
    notifyListeners();
  }
}
