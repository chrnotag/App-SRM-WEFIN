import 'package:Srm_Asset/core/utils/mostrar_botao_ver_assinatura.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:Srm_Asset/core/providers/monitor_assinatura_provider/assinatura_provider.dart';
import 'package:Srm_Asset/core/providers/monitor_operacao_provider/monitor_operacao_impl.dart';

import '../../../models/monitor_assinaturas_model/monitor_assinaturas_model.dart';
import '../../../models/monitor_operacoes_model/monitor_operacoes_model.dart';
import '../../constants/tema_configs.dart';
import '../../implementations_config/api_response.dart';

class MonitorOperacoesProvider extends ChangeNotifier {
  List<MonitorOperacoesModel> _operacoes = [];

  List<MonitorOperacoesModel> get operacoes => _operacoes;

  set operacoes(List<MonitorOperacoesModel> data) {
    _operacoes = ordenarLista(data);
    notifyListeners();
  }

  List<MonitorOperacoesModel> ordenarLista(List<MonitorOperacoesModel> lista) {
    lista.sort((a, b) {
      var visivelA = ExibirVerAssinatura.isVisivel(a) ? 1 : 0;
      var visivelB = ExibirVerAssinatura.isVisivel(b) ? 1 : 0;
      return visivelB.compareTo(visivelA);
    });
    return lista;
  }

  Future<ApiResponse<dynamic>> carregarOperacoes() async {
    final response = await MonitorOperacaoImpl().carregarOperacoes();
    notifyListeners();
    return response;
  }

  List<MonitorAssinaturasModel> aconragemAssinatura(
      List<MonitorAssinaturasModel> lista, int codigoBuscado) {
    int index =
        lista.indexWhere((element) => element.codigoOperacao == codigoBuscado);

    if (index != -1) {
      MonitorAssinaturasModel elementoEncontrado = lista.removeAt(index);
      lista.insert(0, elementoEncontrado);
      final AssinaturaProvider assinaturaProvider =
          Modular.get<AssinaturaProvider>();
      assinaturaProvider.todasAssinaturas = lista;
      notifyListeners();
    }
    return lista;
  }

  Map<String, Color> corOperacao = {
    'EM DIGITAÇÃO': AppColors.azulPrimarioSRM,
    'ENVIADA': AppColors.azulPrimarioSRM,
    'EM ANÁLISE': AppColors.laranja,
    'AUTORIZADA': AppColors.laranja,
    'AGUARDANDO ASSINATURA': AppColors.laranja,
    'ASSINADA': AppColors.laranja,
    'PAGAMENTO ENVIADO': AppColors.verdePrimarioTRUST,
    'COBRANÇA': AppColors.verdePrimarioTRUST
  };
}
