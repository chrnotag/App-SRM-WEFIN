import 'package:Srm_Asset/core/constants/extensions/theme_extensions.dart';
import 'package:Srm_Asset/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_implementation.dart';
import 'package:Srm_Asset/core/providers/auth_provider_config/logar/auth_providers.dart';
import 'package:Srm_Asset/models/monitor_assinaturas_model/monitor_assinaturas_model.dart';

import '../../../models/auth_login_models/SRM/cedente_model.dart';

class AssinaturaProvider extends ChangeNotifier {
  AssinaturaProvider._();

  static final _instance = AssinaturaProvider._();

  factory AssinaturaProvider() => _instance;

  Future<ApiResponse<dynamic>> carregarAssinaturas() async {
    final response = await AssinaturaImpl().assinaturas();
    notifyListeners();
    return response;
  }

  Future<ApiResponse<dynamic>>? _assinaturasFuture;
  Future<ApiResponse<dynamic>>? get assinaturasFuture => _assinaturasFuture;
  set assinaturasFuture(Future<ApiResponse<dynamic>>? assinaturas) => _assinaturasFuture = assinaturas;

  String? _valorSelecionado;
  String? get valorSelecionado => _valorSelecionado;
  set valorSelecionado(String? valor) => _valorSelecionado = valor;

  List<CedenteModel> _listaItens = [];
  List<CedenteModel> get listaItens => _listaItens;
  set listaItens(List<CedenteModel> lista) => _listaItens = lista;

  Future<void> carregarDados() async {
    assinaturasFuture =
        Modular.get<AssinaturaProvider>().carregarAssinaturas();
    final authProvider = Modular.get<AuthProvider>();
    valorSelecionado = authProvider.empresaSelecionada!.identificador;
    listaItens = authProvider.listaCedente!;
    notifyListeners();
  }

  List<MonitorAssinaturasModel> _testeAssinatura =[];
  List<MonitorAssinaturasModel> get testeAssinatura => _testeAssinatura;
  set testeAssinaturas(List<MonitorAssinaturasModel> assinaturas) {
    _testeAssinatura = assinaturas;
    notifyListeners();
  }

  bool _existemProcuradores = true;

  bool get existemProcuradores => _existemProcuradores;

  set existemProcuradores(bool existe) {
    _existemProcuradores = existe;
  }

  set assinaturas(List<MonitorAssinaturasModel> assinaturasModel) {
    todasAssinaturas = assinaturasModel;
    notifyListeners();
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

  Color definirCorStatusAssinatura(String status, BuildContext context) {
    return status == "Assinado" ? context.successColor : context.waitingColor;
  }

  void separaAssinaturas(List<MonitorAssinaturasModel> assinaturas) {
    _assinaturasPendentes.clear();

    final AuthProvider authProvider = Modular.get<AuthProvider>();
    bool naoAssinadoPeloUsuario = false;
    for (var assinatura in assinaturas) {
      if (assinatura.statusAssinaturaDigital!.toLowerCase() != "assinado") {
        naoAssinadoPeloUsuario = assinatura.assinantes
            .any((assinante) => assinante.informacoesAssinante.any((info) {
                  return info.identificadorAssinador ==
                          authProvider.dataUser!.identificadorUsuario &&
                      info.statusAssinatura!.toLowerCase() != "assinado";
                }));
        if (naoAssinadoPeloUsuario) {
          _assinaturasPendentes.add(assinatura);
        }
      }
    }
  }

  Color corStatusAssinatura(String status, BuildContext context) {
    if (status.toLowerCase().trim() == "aguardando assinatura") {
      return context.waitingColor;
    }
    return context.successColor;
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
