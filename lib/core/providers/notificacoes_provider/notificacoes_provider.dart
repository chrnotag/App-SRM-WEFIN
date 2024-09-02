import 'package:Srm_Asset/core/providers/notificacoes_provider/notificacoes_impl.dart';
import 'package:Srm_Asset/models/notificacoes/notificacoes_model.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/toast_erro_util.dart';

class NotificacoesProvider extends ChangeNotifier {
  List<NotificacoesModel> _notificacoes = [];

  List<NotificacoesModel> get notificacoes => _notificacoes;

  set notificacoes(List<NotificacoesModel> notificacao) =>
      _notificacoes = notificacao;

  Future<void> pegarNotificacoes() async {
    final response = await NotificacoesImpl.pegarNotificacoes();
    if (response.error == null) {
      notificacoes = response.data;
    } else {
      showToast('Erro: ', response);
    }
  }

  void limparNotificacoes(){
    _notificacoes = [];
  }

  Future<void>? _futureNotificacoes;
  Future<void>? get futureNotificacoes => _futureNotificacoes;
  set futureNotificacoes(Future<void>? notificacoes) => _futureNotificacoes = notificacoes;

  Future<void> marcarLido() async {
    for (var notificacao in notificacoes) {
      final response = await NotificacoesImpl.marcarLido(notificacao);
      if (response.error != null) {
        break;
      }
    }
  }
}
