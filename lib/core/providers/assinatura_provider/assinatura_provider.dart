import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/assinatura_provider/assinatura_implementation.dart';
import 'package:modular_study/core/providers/auth_provider_config/auth_providers.dart';
import 'package:modular_study/models/assinaturas_model/assinaturas_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  pegarAssinaturas() {
    return AssinaturaImpl().assinaturas();
  }

  set assinaturas(List<AssinaturasModel> assinaturasModel) {
    separaAssinaturas(assinaturasModel);
    todasAssinaturas = assinaturasModel;
    notifyListeners();
  }

  AssinaturasModel? _assinaturaSelecionada;

  AssinaturasModel? get assinaturaSelecionada => _assinaturaSelecionada;

  set assinaturaSelecionada(AssinaturasModel? assinatura) {
    _assinaturaSelecionada = assinatura;
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

  String traduzirStatusAssinaturas(AssinaturasModel assinatura) {
    final status = assinatura.statusAssinaturaDigital.toUpperCase();
    const assinado = ['FINALIZADO', 'ASSINADO_CLIENTE', 'ACEITO', 'ENVIADO'];
    if (assinado.contains(status)) {
      return "Assinado";
    } else {
      return "Aguardando Assinatura";
    }
  }

  Color definirCorStatusAssinatura(String status) {
    if (status == "Assinado") {
      return AppColors.statusVerde;
    } else {
      return AppColors.statusAzul;
    }
  }

  void separaAssinaturas(List<AssinaturasModel> assinaturas) {
    final AuthProvider authProvider = Modular.get<AuthProvider>();
    for (var assinatura in assinaturas) {
      bool naoAssinadoPeloUsuario = assinatura.assinantes.any((assinante) =>
          assinante.informacoesAssinante.any((info) =>
          info.identificadorAssinador ==
              authProvider.dataUser!.identificadorUsuario &&
              info.statusAssinatura != "Assinado"));
      if (naoAssinadoPeloUsuario) {
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
