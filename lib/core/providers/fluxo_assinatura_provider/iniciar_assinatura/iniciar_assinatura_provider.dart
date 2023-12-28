import 'package:flutter/cupertino.dart';
import 'package:modular_study/models/fluxo_assinatura_model/iniciar_assinatura/resposta_iniciar_assinatura.dart';

class IniciarAssinaturaProvider extends ChangeNotifier {
  List<RespostaIniciarAssinaturaModel> _hashsParaAssinar = [];

  List<RespostaIniciarAssinaturaModel> get hashsParaAssinar => _hashsParaAssinar;

  set hashsParaAssinar(List<RespostaIniciarAssinaturaModel> hashs) {
    _hashsParaAssinar = hashs;
    notifyListeners();
  }
}
