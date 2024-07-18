import 'package:Srm_Asset/core/implementations_config/api_response.dart';
import 'package:Srm_Asset/core/providers/conta_digital/solicitacao_ted/solicitacao_ted_impl.dart';
import 'package:Srm_Asset/core/utils/toast_erro_util.dart';
import 'package:flutter/cupertino.dart';
import '../../../../models/conta_digital/solicitacoes_ted/solicitacoes_ted.dart';

class SolicitacoesTedProvider extends ChangeNotifier {

  Future<ApiResponse<dynamic>> carregarSolicitacoesTed(String numeroContaTitular) async {
    final response = await SolicitacaoTedImpl.pegarSolicitacoes(numeroContaTitular);
    notifyListeners();
    if(response.error == null){
      solicitacoesTed = response.data;
    }else{
      showToast('Erro ao carregar solicitações', response);
    }
    return response;
  }
  Future<ApiResponse<dynamic>>? _futureSolicitacoesTed;
  Future<ApiResponse<dynamic>>? get futureSolcitacoesTed => _futureSolicitacoesTed;
  set futureSolicitacoesTed(Future<ApiResponse<dynamic>>? future) => _futureSolicitacoesTed = future;

  SolicitacaoTed? _solicitacoesTed;
  SolicitacaoTed? get solicitacoesTed => _solicitacoesTed;
  set solicitacoesTed(SolicitacaoTed? solicitacoes) {
    _solicitacoesTed = solicitacoes;
    notifyListeners();
  }
}