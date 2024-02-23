import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/constants/themes/theme_configs.dart';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_implementation.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

import '../../utils/money_format.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  Future<ApiResponse<dynamic>> carregarAssinaturas() async {
    final response = await AssinaturaImpl().assinaturas();
    notifyListeners();
    return response;
  }

  set assinaturas(List<MonitorAssinaturasModel> assinaturasModel) {
    separaAssinaturas(assinaturasModel);
    mapearAssinaturas = assinaturasModel;
    todasAssinaturas = assinaturasModel;
  }

  bool _isDestacado = false;

  bool get isDestacado => _isDestacado;

  set isDestacado(bool destacado) {
    _isDestacado = destacado;
  }

  MonitorAssinaturasModel? _assinaturaSelecionada;

  MonitorAssinaturasModel? get assinaturaSelecionada => _assinaturaSelecionada;

  set assinaturaSelecionada(MonitorAssinaturasModel? assinatura) {
    _assinaturaSelecionada = assinatura;
  }

  List<MonitorAssinaturasModel> _assinaturas = [];

  List<MonitorAssinaturasModel> get todasAssinaturas => _assinaturas;

  set todasAssinaturas(List<MonitorAssinaturasModel> assinaturas) {
    _assinaturas = assinaturas;
  }

  List<MonitorAssinaturasModel> _assinaturasPendentes = [];

  List<MonitorAssinaturasModel> get assinaturasPendentes =>
      _assinaturasPendentes;

  set assinaturasPendentes(List<MonitorAssinaturasModel> docs) {
    _assinaturasPendentes = docs;
  }

  String notificacaoPendentes() {
    return assinaturasPendentes.length.toString();
  }

  Color definirCorStatusAssinatura(String status) {
    return status == "Assinado" ? AppColors.verde : AppColors.azulPrimarioSRM;
  }

  void separaAssinaturas(List<MonitorAssinaturasModel> assinaturas) {
    _assinaturasPendentes.clear();

    final AuthProvider authProvider = Modular.get<AuthProvider>();
    bool naoAssinadoPeloUsuario = false;
    for (var assinatura in assinaturas) {
      if (assinatura.statusAssinaturaDigital.toLowerCase() != "assinado") {
        log('operacao ${assinatura.codigoOperacao} tem o status ${assinatura.statusOperacao} e tambpem o status assinatura ${assinatura.statusAssinaturaDigital}');
        naoAssinadoPeloUsuario = assinatura.assinantes
            .any((assinante) => assinante.informacoesAssinante.any((info) {
                  return info.identificadorAssinador ==
                          authProvider.dataUser!.identificadorUsuario &&
                      info.statusAssinatura.toLowerCase() != "assinado";
                }));
        if (naoAssinadoPeloUsuario) {
          _assinaturasPendentes.add(assinatura);
        }
      }
    }
  }

  Color corStatusAssinatura(String status) {
    if (status.toLowerCase().trim() == "aguardando assinatura") {
      return AppColors.azulPrimarioSRM;
    }
    return AppColors.verdePrimarioTRUST;
  }

  Map<int, MonitorAssinaturasModel> _mapaAssinaturas = {};

  Map<int, MonitorAssinaturasModel> get assinaturasMapeadas => _mapaAssinaturas;

  set mapearAssinaturas(List<MonitorAssinaturasModel> assinaturas) {
    for (var assinatura in assinaturas) {
      _mapaAssinaturas[assinatura.codigoOperacao] = assinatura;
    }
  }

  void limparAssinaturas() {
    _assinaturas = [];
    _assinaturasPendentes = [];
    _assinaturaSelecionada = null;
    _mapaAssinaturas = {};
  }
}
