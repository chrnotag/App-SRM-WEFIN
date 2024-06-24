import 'dart:convert';

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

  set assinaturasFuture(Future<ApiResponse<dynamic>>? assinaturas) =>
      _assinaturasFuture = assinaturas;

  String? _valorSelecionado;

  String? get valorSelecionado => _valorSelecionado;

  set valorSelecionado(String? valor) => _valorSelecionado = valor;

  List<CedenteModel> _listaCedentes = [];

  List<CedenteModel> get listaCedentes => _listaCedentes;

  set listaCedentes(List<CedenteModel> lista) => _listaCedentes = lista;

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

  bool estaAguardandoAssinaturaUsuarioAtual(
      MonitorAssinaturasModel operacao, String identificadorUsuario) {
    if (operacao.statusAssinaturaDigital!.toLowerCase() != "assinado") {
      return operacao.assinantes
          .any((assinante) => assinante.informacoesAssinante.any((info) {
                return info.identificadorAssinador == identificadorUsuario &&
                    info.statusAssinatura!.toLowerCase() != "assinado";
              }));
    }
    return false;
  }

  List<MonitorAssinaturasModel> ordenarOperacoes(
      List<MonitorAssinaturasModel> operacoesFiltradas,
      String identificadorUsuario) {
    operacoesFiltradas.sort((op1, op2) {
      bool op1AguardandoAssinaturaUsuarioAtual =
          estaAguardandoAssinaturaUsuarioAtual(op1, identificadorUsuario);
      bool op2AguardandoAssinaturaUsuarioAtual =
          estaAguardandoAssinaturaUsuarioAtual(op2, identificadorUsuario);

      // Prioridade 1: Aguardando assinatura do usuário atual
      if (op1AguardandoAssinaturaUsuarioAtual &&
          !op2AguardandoAssinaturaUsuarioAtual) {
        return -1;
      } else if (!op1AguardandoAssinaturaUsuarioAtual &&
          op2AguardandoAssinaturaUsuarioAtual) {
        return 1;
      }

      // Prioridade 2: Aguardando assinatura (de qualquer usuário)
      if (op1.statusAssinaturaDigital == 'Aguardando Assinatura' &&
          op2.statusAssinaturaDigital != 'Aguardando Assinatura') {
        return -1;
      } else if (op1.statusAssinaturaDigital != 'Aguardando Assinatura' &&
          op2.statusAssinaturaDigital == 'Aguardando Assinatura') {
        return 1;
      }

      // Prioridade 3: Assinada
      if (op1.statusAssinaturaDigital == 'Assinado' &&
          op2.statusAssinaturaDigital != 'Assinado') {
        return -1;
      } else if (op1.statusAssinaturaDigital != 'Assinado' &&
          op2.statusAssinaturaDigital == 'Assinado') {
        return 1;
      }

      // Prioridade 4: Rejeitada
      if (op1.statusAssinaturaDigital == 'Rejeitado' &&
          op2.statusAssinaturaDigital != 'Rejeitado') {
        return -1;
      } else if (op1.statusAssinaturaDigital != 'Rejeitado' &&
          op2.statusAssinaturaDigital == 'Rejeitado') {
        return 1;
      }

      // Prioridade 5: Não Iniciada
      if (op1.statusAssinaturaDigital == 'Nao Inicializado' &&
          op2.statusAssinaturaDigital != 'Nao Inicializado') {
        return -1;
      } else if (op1.statusAssinaturaDigital != 'Nao Inicializado' &&
          op2.statusAssinaturaDigital == 'Nao Inicializado') {
        return 1;
      }

      // Se os critérios anteriores não se aplicam, mantenha a ordem original
      return 0;
    });
    return operacoesFiltradas;
  }

  Future<void> carregarDados() async {
    assinaturasFuture = Modular.get<AssinaturaProvider>().carregarAssinaturas();
    final authProvider = Modular.get<AuthProvider>();
    valorSelecionado = authProvider.empresaSelecionada!.identificador;
    listaCedentes = authProvider.listaCedente!;
  }

  Color corStatusAssinatura(String statusAssinatura) {
    switch (statusAssinatura) {
      case 'Aguardando Assinatura':
        return Color(0XFFE1C11A);
      case 'Assinado':
        return Colors.green;
      case 'Nao Inicializado':
        return Colors.blue;
      default:
        return Colors.red;
    }
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
