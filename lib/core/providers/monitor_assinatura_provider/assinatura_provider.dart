import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_study/core/constants/extensions/theme_extensions.dart';
import 'package:modular_study/core/constants/themes/theme_configs.dart';
import 'package:modular_study/core/providers/monitor_assinatura_provider/assinatura_implementation.dart';
import 'package:modular_study/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:modular_study/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  pegarAssinaturas() {
    return AssinaturaImpl().assinaturas();
  }

  set assinaturas(List<MonitorAssinaturasModel> assinaturasModel) {
    separaAssinaturas(assinaturasModel);
    todasAssinaturas = assinaturasModel;
    notifyListeners();
  }

  MonitorAssinaturasModel? _assinaturaSelecionada;

  MonitorAssinaturasModel? get assinaturaSelecionada => _assinaturaSelecionada;

  set assinaturaSelecionada(MonitorAssinaturasModel? assinatura) {
    _assinaturaSelecionada = assinatura;
    notifyListeners();
  }

  List<MonitorAssinaturasModel> _assinaturas = [];

  List<MonitorAssinaturasModel> get todasAssinaturas => _assinaturas;

  set todasAssinaturas(List<MonitorAssinaturasModel> assinaturas) =>
      _assinaturas = assinaturas;

  List<MonitorAssinaturasModel> _assinaturasPendentes = [];

  List<MonitorAssinaturasModel> get assinaturasPendentes => _assinaturasPendentes;

  set assinaturasPendentes(List<MonitorAssinaturasModel> docs) {
    _assinaturasPendentes = docs;
  }

  String notificacaoPendentes() {
    return assinaturasPendentes.length.toString();
  }

  String traduzirStatusAssinaturas(MonitorAssinaturasModel assinatura) {
    final status = assinatura.statusAssinaturaDigital.toUpperCase();
    const assinado = ['FINALIZADO', 'ASSINADO_CLIENTE', 'ACEITO', 'ENVIADO', 'COMP'];
    return assinado.contains(status) ? "Assinado" : "Aguardando Assinatura";
  }

  Color definirCorStatusAssinatura(String status) {
    return status == "Assinado" ? AppColors.verde : AppColors.azulPrimarioSRM;
  }

  void separaAssinaturas(List<MonitorAssinaturasModel> assinaturas) {
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

  Widget traduzirStatusAssinatura(String status, BuildContext context) {
    log("status assinatura: $status");
    return status.trim() == "Aguardando Assinatura"
        ? Text(
      "Aguardando Assinatura",
      style: context.textTheme.bodySmall!
          .copyWith(color: AppColors.azulPrimarioSRM),
    )
        : Text("Assinado",
        style: context.textTheme.bodySmall!
            .copyWith(color: AppColors.verde));
  }

  void limparAssinaturas() {
    todasAssinaturas = [];
    assinaturasPendentes = [];
    assinaturaSelecionada = null;
    assinaturas = [];
    notifyListeners();
  }
}
